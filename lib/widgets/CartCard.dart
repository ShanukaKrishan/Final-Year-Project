import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/cartProvider.dart';

class CartItemCard extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String imageUrl;
  final String productId;

  const CartItemCard(
      {Key? key,
      required this.id,
      required this.imageUrl,
      required this.price,
      required this.productId,
      required this.quantity,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Dismissible(
          confirmDismiss: (direction) async {
            await CoolAlert.show(
                context: context,
                type: CoolAlertType.confirm,
                backgroundColor: Colors.white,
                title: "Delete all items?",
                confirmBtnText: "Confirm",
                cancelBtnTextStyle: const TextStyle(color: Colors.white),
                confirmBtnColor: const Color.fromRGBO(126, 94, 81, 1),
                onConfirmBtnTap: () {
                  Navigator.pop(context);
                  Provider.of<CartProvider>(context, listen: false)
                      .removeItem(productId);
                });
            return null;
          },
          key: ValueKey(id),
          background: Container(
            decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.w,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(235, 235, 235, 1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                              imageUrl: imageUrl, fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(20)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontFamily: kDMSerifDisplay,
                              fontSize: 16,
                            ),
                          ),
                          Text("Total \$${price * quantity}")
                        ],
                      )
                    ],
                  ),
                  Text(quantity.toString() + "x"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
