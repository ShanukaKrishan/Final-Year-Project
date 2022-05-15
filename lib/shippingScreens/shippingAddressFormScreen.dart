import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_store/providers/addressProvider.dart';
import 'package:watch_store/providers/productsProvider.dart';
import 'package:watch_store/shippingScreens/shippingAddressScreen.dart';
import '../constants.dart';
import '../widgets/customButtons.dart';
import '../widgets/widgetAppBar.dart';

class AddressForm extends StatefulWidget {
  static String routeName = '/addressShippingScreen';

  const AddressForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final GlobalKey<FormState> _shippingKey = GlobalKey<FormState>();

  String _countryValue = "Select country";
  final _addressOne = TextEditingController();
  String _addressTwo = '';
  final _zipCode = TextEditingController();
  String country = "Kuwait";
  final _phone = TextEditingController();
  bool _toggleValue = false;
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    assignAddress(context);
    super.didChangeDependencies();
  }

  void assignAddress(BuildContext context) {
    final addressProvider = Provider.of<UserAddress>(context).address;
    _countryValue = addressProvider[0].country;
    _zipCode.text = addressProvider[0].zipCode;
    _phone.text = addressProvider[0].phone;
    _addressOne.text = addressProvider[0].addressOne;
    _addressTwo = addressProvider[0].addressTwo;
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<UserAddress>(context);
    Widget _buildSwitch() => Transform.scale(
          scale: 1,
          child: Switch.adaptive(
              activeColor: kPrimaryColor,
              value: _toggleValue,
              onChanged: (value) => setState(() {
                    _toggleValue = value;
                  })),
        );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const WidgetAppBar(
                appBarTitle: "UPDATE ADDRESS",
              ),
              SizedBox(height: 20),
              Form(
                key: _shippingKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _addressOne,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Address Line 1";
                          } else if (value.length < 4) {
                            return "Address can't be less than 4 characters";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "City, Street no, House no"),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) {
                          _addressTwo = value;
                        },
                        decoration: const InputDecoration(
                            hintText: "Address 2 (optional)"),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _zipCode,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Zip Code can't be empty";
                          } else if (!value.contains(RegExp(r'[0-9]'))) {
                            return "Zip Code cannot contain alphabets";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "Zip Code"),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _countryValue,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          CountryCodePicker(
                            onChanged: (country) {
                              setState(() {
                                _countryValue = country.name!;
                              });
                            },
                            hideMainText: true,
                            showCountryOnly: true,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey.shade600,
                      ),
                      TextFormField(
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone number can't be empty";
                          } else if (!value.contains(RegExp(r'[0-9]'))) {
                            return "Phone number cannot contain alphabets";
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(hintText: "Phone number"),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Set Default Address",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            _buildSwitch(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomButton(
                          buttonText: "UPDATE",
                          press: () async {
                            if (_shippingKey.currentState!.validate()) {
                              await addressProvider.saveAddress(
                                  _addressOne.text,
                                  _addressTwo,
                                  _zipCode.text,
                                  _countryValue,
                                  _phone.text);
                              // await addressProvider.getAddressFromFirebase();
                              Navigator.pushReplacementNamed(
                                  context, ShippingAddressScreen.routeName);
                            }
                          }),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
