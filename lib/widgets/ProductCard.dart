import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/constants.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String id;
  final String price;
  const ProductCard(
      {Key? key,
      required this.id,
      required this.title,
      this.price = '',
      required this.imageUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imageUrl,
            width: ScreenUtil().setWidth(200),
            height: 210,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(fontSize: 17, fontFamily: kDMSerifDisplay),
        ),
        Text(price.toString(),
            style: const TextStyle(
                fontSize: 20,
                fontFamily: kDMSerifDisplay,
                color: kPrimaryColor))
      ],
    );
  }
}
