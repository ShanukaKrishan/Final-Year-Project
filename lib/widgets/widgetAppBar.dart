import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cartScreen/cartScreen.dart';
import '../constants.dart';
import '../providers/cartProvider.dart';
import 'cartBadge.dart';

class WidgetAppBar extends StatelessWidget {
  final String appBarTitle;
  const WidgetAppBar({
    Key? key,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: FlatButton(
                onPressed: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Text(
              appBarTitle,
              style: const TextStyle(
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
    );
  }
}
