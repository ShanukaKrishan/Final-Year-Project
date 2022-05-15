import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CommonProduct extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  const CommonProduct(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //color: Colors.grey,
          color: const Color.fromRGBO(235, 235, 235, 1),
        ),
        child: Column(
          children: [
            getImage(context, imageUrl),
            //Image.asset(imageUrl, width: 90, height: 190, fit: BoxFit.fill),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              '\$' + price.toString(),
              style: const TextStyle(
                  color: kPrimaryColor,
                  fontFamily: kDMSerifDisplay,
                  fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }

  Widget getImage(BuildContext context, imageUrl) {
    return CachedNetworkImage(
        imageUrl: imageUrl, width: 100, height: 180, fit: BoxFit.fill);
    //return await CachedNetworkImage(child: Image.network(imageUrl, width: 90, height: 190, fit: BoxFit.fill), context);
  }
}
