import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:watch_store/cartScreen/cartScreen.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/homeScreen/homeScreen.dart';
import 'package:watch_store/main.dart';
import 'package:watch_store/orderHistoryScreen/orderHistoryScreen.dart';
import 'package:watch_store/paymentScreen/paymentScreen.dart';
import 'package:watch_store/providers/addressProvider.dart';
import 'package:watch_store/shippingScreens/shippingAddressScreen.dart';
import 'package:watch_store/stripeScreen/stripeScreen.dart';

import '../providers/cartProvider.dart';
import '../widgets/CartCard.dart';
import '../widgets/OrderItemCard.dart';
import '../providers/orderProvider.dart';
import '../widgets/customButtons.dart';

class OrderDetailScreen extends StatefulWidget {
  static String routeName = '/OrderDetailScreen';

  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  Map<String, dynamic>? paymentIntentData;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final provider = Provider.of<UserAddress>(context, listen: false);

      await provider.getAddressFromFirebase();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final order = Provider.of<OrderProvider>(context, listen: false);
    final addressProvider =
        Provider.of<UserAddress>(context, listen: true).address;
    print(addressProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: const Text(
          "ORDER DETAILS",
          style: kTextAppBarTitle,
        ),
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.popAndPushNamed(context, CartScreen.routeName),
        ),
      ),
      body: Consumer<UserAddress>(builder: (context, provider, child) {
        if (provider.addressFetching) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (provider.address.isNotEmpty) {
          return SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "SHIP TO",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 17,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, ShippingAddressScreen.routeName);
                          },
                          child: const Text(
                            "Change address",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      provider.address[0].addressOne,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    provider.address[0].addressTwo.isEmpty
                        ? const SizedBox()
                        : Text(
                            provider.address[0].addressTwo,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                    Text(
                      provider.address[0].zipCode,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      provider.address[0].country,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(color: Colors.grey.shade500),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PERSONAL DETAILS",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 17,
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //    Navigator.p
                        //   },
                        //   child: const Text(
                        //     "",
                        //     style: TextStyle(
                        //       color: kPrimaryColor,
                        //       fontSize: 16,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Email   :  ' +
                          FirebaseAuth.instance.currentUser!.email.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Phone :  ' + provider.address[0].phone,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    Text(
                      "ORDER DETAILS",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cart.itemCount,
                      itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: OrderItemCard(
                          id: cart.cartItems.values.toList()[i].id.toString(),
                          imageUrl: cart.cartItems.values.toList()[i].imageUrl,
                          productId: cart.cartItems.keys.toList()[i],
                          title: cart.cartItems.values.toList()[i].title,
                          price: cart.cartItems.values
                              .toList()[i]
                              .price
                              .toString(),
                          quantity: cart.cartItems.values.toList()[i].quantity,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(color: Colors.grey.shade600),
                  ],
                )),
          );
        }
        return Center(child: CircularProgressIndicator());
      }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 30.h),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADDADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      text: "Total Price  \n",
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: kDMSerifDisplay,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                            text: "\$" + cart.totalAmount.toString(),
                            style: const TextStyle(
                                fontSize: 22, fontFamily: kDMSerifDisplay)),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: ScreenUtil().setWidth(190),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          primary: kPrimaryColor,
                        ),
                        onPressed: () async {
                          await makePayment();

                          // order.addOrder(
                          //     cart.cartItems.values.toList(), cart.totalAmount);
                          //
                          // Navigator.pushNamed(
                          //     context, PaymentGateWay.routeName);
                          // Navigator.Navigator.of(context).popUntil(
                          //     ModalRoute.withName(CartScreen.routeName));
                          //Navigator.pushNamed(context, HomeScreen.routeName);
                        },
                        child: const Text(
                          "Place Order",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    final cart = Provider.of<CartProvider>(context, listen: false)
        .totalAmount
        .toString();

    try {
      paymentIntentData =
          await createPaymentIntent(cart, 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    try {
      await Stripe.instance
          .presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(
          clientSecret: paymentIntentData!['client_secret'],
          confirmPayment: true,
        ),
      )
          .then((newValue) async {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());

        orderProvider.sendOrder(context);
        Navigator.pushReplacementNamed(context, StartPoint.routeName);
        Flushbar(
          title: "Success",
          message: "Payment Successful \n Order Placed",
          backgroundColor: Colors.green,
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 3),
        ).show(context);
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KgtQeKwCKbCno4TW863AX2u0AIlOaf9hNdbb3ZqdUeumAnW4p9ilVLXYSkf2Vd3Fm4wRcK3e9Pkgz1oEO9nkX5H00x1uOZzyM',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
