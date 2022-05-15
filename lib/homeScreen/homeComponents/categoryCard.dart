import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watch_store/constants.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String categoryName;
  final String catId;

  const CategoryCard(
      {Key? key,
      required this.imageUrl,
      required this.categoryName,
      required this.catId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 170,
                height: 210,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              categoryName,
              style: const TextStyle(
                fontFamily: kDMSerifDisplay,
                fontSize: 17,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
