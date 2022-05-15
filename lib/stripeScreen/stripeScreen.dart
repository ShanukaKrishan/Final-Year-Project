import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:watch_store/main.dart';
import 'package:watch_store/orderHistoryScreen/orderHistoryScreen.dart';

import '../providers/cartProvider.dart';

class PaymentGateWay extends StatefulWidget {
  static String routeName = '/StripeScreen';

  const PaymentGateWay({Key? key}) : super(key: key);

  @override
  _PaymentGateWayState createState() => _PaymentGateWayState();
}

class _PaymentGateWayState extends State<PaymentGateWay> {
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stripe Tutorial'),
      ),
      body: Center(
        child: InkWell(
          onTap: () async {},
          child: Container(
            height: 50,
            width: 200,
            color: Colors.green,
            child: Center(
              child: Text(
                'Pay',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
