import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:watch_store/models/catergory.dart';
import 'categoryCard.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<CategoryType> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 245,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategoryCard(
            imageUrl: categories[index].categoryImageUrl,
            categoryName: categories[index].categoryType),
        itemCount: categories.length,
      ),
    );
  }
}
