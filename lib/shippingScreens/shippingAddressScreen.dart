import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:watch_store/OrderDetailScreen/orderDetailScreen.dart';
import 'package:watch_store/models/address.dart';
import 'package:watch_store/paymentScreen/paymentScreen.dart';
import 'package:watch_store/productDetailScreen/productDetailScreen.dart';
import 'package:watch_store/providers/addressProvider.dart';
import 'package:watch_store/providers/productsProvider.dart';
import 'package:watch_store/shippingScreens/shippingAddressFormScreen.dart';

import 'package:watch_store/widgets/customButtons.dart';

import '../constants.dart';

import '../widgets/widgetAppBar.dart';

class ShippingAddressScreen extends StatefulWidget {
  static String routeName = '/shippingScreen';
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  bool _checkAddress = false;
  final GlobalKey<FormState> _shippingKey = GlobalKey<FormState>();

  String _countryValue = "Select Country";
  final _addressOne = TextEditingController();
  String _addressTwo = '';
  final _zipCode = TextEditingController();
  String country = "Kuwait";
  final _phone = TextEditingController();
  bool _toggleValue = false;
  DocumentSnapshot? snapshot;
  Future<void> checkAddress() async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    final userAddress = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('userAddress')
        .get();

    if (userAddress.docs.length == 0) {
      setState(() {
        _checkAddress = true;
      });
    } else {
      snapshot = userAddress.docs[0];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final address = Provider.of<UserAddress>(context, listen: false);

      await address.getAddressFromFirebase();
    });
    super.initState();
  }

  Widget _buildSwitch() => Transform.scale(
        scale: 1,
        child: Switch.adaptive(
            activeColor: kPrimaryColor,
            value: _toggleValue,
            onChanged: (value) => setState(() {
                  _toggleValue = value;
                })),
      );

  @override
  Widget build(BuildContext context) {
    final address = Provider.of<UserAddress>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const WidgetAppBar(
                appBarTitle: "SHIPPING ADDRESS",
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: const <Widget>[
                    SizedBox(height: 5),
                    Text(
                      "Enter your shipping address, so we can ship your product directly to your doorstep",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Consumer<UserAddress>(builder: (context, provider, child) {
                if (provider.addressFetching) {
                  return const Center(
                    child: CircularProgressIndicator(color: kPrimaryColor),
                  );
                }
                if (provider.address.isEmpty) {
                  return addressForm();
                }
                return addressTitle(address.address);
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget addressForm() {
    final addressProvider = Provider.of<UserAddress>(context);
    return Form(
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
              decoration:
                  const InputDecoration(hintText: "City, Street no, House no"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              onChanged: (value) {
                _addressTwo = value;
              },
              decoration:
                  const InputDecoration(hintText: "Address 2 (optional)"),
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
                  initialSelection: 'KW',
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
              decoration: const InputDecoration(hintText: "Phone number"),
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
                buttonText: "Next",
                press: () async {
                  if (_shippingKey.currentState!.validate()) {
                    print(_zipCode.text);
                    print(_countryValue);
                    print(_phone.text);
                    await addressProvider.saveAddress(_addressOne.text,
                        _addressTwo, _zipCode.text, _countryValue, _phone.text);
                    pushNewScreen(context, screen: OrderDetailScreen());
                  }
                }),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget addressTitle(List<AddressModel> address) {
    final clear = Provider.of<UserAddress>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const Text("Saved address",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontFamily: kDMSerifDisplay)),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.black87,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _addressText(address[0].phone),
                        _addressText(address[0].addressOne),
                        _addressText(address[0].addressTwo),
                        _addressText(address[0].zipCode),
                        _addressText(address[0].country),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AddressForm.routeName);
                          },
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                            onPressed: () {
                              clear.deleteAddress(address[0].userId);
                            },
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon:
                                Icon(Icons.delete, color: Colors.red.shade400)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 110),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(220, 45),
                  primary: kPrimaryColor),
              onPressed: () {
                pushNewScreen(context,
                    screen: const OrderDetailScreen(), withNavBar: false);
              },
              child: const Text(
                "Check Out",
                style: TextStyle(fontFamily: kDMSerifDisplay),
              ))
        ],
      ),
    );
  }

  Text _addressText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.white),
    );
  }
}
