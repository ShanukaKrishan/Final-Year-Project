import 'package:country_code_picker/country_code_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_store/paymentScreen/paymentScreen.dart';

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
  @override
  Widget build(BuildContext context) {
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
              const AddressForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressForm extends StatefulWidget {
  const AddressForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _AddressFormState extends State<AddressForm> {
  String _countryValue = "Select Country";
  bool _toggleValue = false;
  @override
  Widget build(BuildContext context) {
    Widget _buildSwitch() => Transform.scale(
          scale: 1,
          child: Switch.adaptive(
              activeColor: kPrimaryColor,
              value: _toggleValue,
              onChanged: (value) => setState(() {
                    _toggleValue = value;
                  })),
        );

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Name can't be empty";
                } else if (value.length < 4) {
                  return "Name can't be less than 4 characters";
                }
                return null;
              },
              decoration: const InputDecoration(hintText: "Name"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return " Email can't be empty";
                } else if (!emailValidatorRegExp.hasMatch(value)) {
                  return "Enter a valid email";
                }
                return null;
              },
              decoration: const InputDecoration(hintText: "Email Address"),
            ),
            const SizedBox(height: 20),
            TextFormField(
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
              decoration: const InputDecoration(hintText: "Optional"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Zip Code";
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
            const SizedBox(height: 30),
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
                press: () =>
                    Navigator.pushNamed(context, PaymentScreen.routeName)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
// CSCPicker(
// layout: Layout.vertical,
// defaultCountry: DefaultCountry.Sri_Lanka,
// flagState: CountryFlag.ENABLE,
// countryDropdownLabel: countryValue,
//
// //dropdownDecoration: const BoxDecoration(),
// showCities: false,
//
// showStates: false,
// selectedItemStyle: const TextStyle(
// color: Colors.black,
// fontFamily: kSourceSansPro,
// fontSize: 16,
// ),
// dropdownHeadingStyle: const TextStyle(
// color: kPrimaryColor,
// fontFamily: kDMSerifDisplay,
// fontSize: 16),
// onStateChanged: (value) {
// setState(() {
// var stateValue = value;
// });
// },
// onCityChanged: (value) {
// var cityValue = value;
// },
// onCountryChanged: (value) {
// FocusScope.of(context).unfocus();
//
// setState(() {
// countryValue = value;
// });
// },
// ),
