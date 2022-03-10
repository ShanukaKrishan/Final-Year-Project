import 'package:flutter/material.dart';
import 'package:watch_store/cartScreen/cartScreen.dart';
import 'package:watch_store/constants.dart';

class OrderDetailScreen extends StatefulWidget {
  static String routeName = '/OrderDetailScreen';

  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ORDER DETAILS",
          style: kTextAppBarTitle,
        ),
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.popAndPushNamed(context, CartScreen.routeName),
        ),
      ),
    );
  }
}
