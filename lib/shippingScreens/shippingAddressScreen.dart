import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:watch_store/widgets/customButtons.dart';
import 'package:country_list_pick/country_list_pick.dart';

import '../cartScreen/cartScreen.dart';
import '../constants.dart';
import '../providers/cartProvider.dart';
import '../widgets/cartBadge.dart';

class ShippingAddressScreen extends StatefulWidget {
  static String routeName = '/shippingScreen';
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.black),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child:
                              const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                      const Text(
                        "SHIPPING ADDRESS",
                        style: TextStyle(
                            fontFamily: kDMSerifDisplay,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      Consumer<CartProvider>(
                        builder: (_, cartData, ch) => CartBadge(
                            child: ch!,
                            value: cartData.itemCount == 0
                                ? 0.toString()
                                : cartData.itemCount.toString(),
                            color: kPrimaryColor),
                        child: IconButton(
                          icon: const Icon(Icons.shopping_bag_outlined,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.pushNamed(context, CartScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
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
                        decoration:
                            const InputDecoration(hintText: "Email Address"),
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
                        decoration: const InputDecoration(
                            hintText: "Street no, House no"),
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
                      CountryListPick(
                          appBar: AppBar(
                            backgroundColor: Colors.blue,
                            title: Text('Choisir un pays'),
                          ),

                          // if you need custome picker use this
                          // pickerBuilder: (context, CountryCode countryCode){
                          //   return Row(
                          //     children: [
                          //       Image.asset(
                          //         countryCode.flagUri,
                          //         package: 'country_list_pick',
                          //       ),
                          //       Text(countryCode.code),
                          //       Text(countryCode.dialCode),
                          //     ],
                          //   );
                          // },

                          // To disable option set to false
                          theme: CountryTheme(
                            isShowFlag: true,
                            isShowTitle: true,
                            isShowCode: true,
                            isDownIcon: true,
                            showEnglishName: true,
                          ),
                          // Set default value
                          initialSelection: '+62',
                          // or
                          // initialSelection: 'US'

                          // Whether to allow the widget to set a custom UI overlay
                          useUiOverlay: true,
                          // Whether the country list should be wrapped in a SafeArea
                          useSafeArea: false),
                      const SizedBox(height: 15),
                      CustomButton(buttonText: "Next", press: () {}),
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
