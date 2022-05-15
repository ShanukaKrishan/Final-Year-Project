import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class OrderItemCard extends StatelessWidget {
  final String id;
  final String price;
  final int quantity;
  final String title;
  final String imageUrl;
  final String productId;

  const OrderItemCard(
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
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 120.h,
                width: 120.w,
                // padding: const EdgeInsets.all(10),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                //   color: const Color.fromRGBO(235, 235, 235, 1),
                // ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
                      CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: ScreenUtil().setWidth(20)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "\$${price * quantity}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: kDMSerifDisplay,
                    ),
                  )
                ],
              )
            ],
          ),
          Text(quantity.toString() + "x"),
        ],
      ),
    );
  }
}
