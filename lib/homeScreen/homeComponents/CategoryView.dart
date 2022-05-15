import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:watch_store/categoryScreen/categoryScreen.dart';
import 'package:watch_store/models/catergory.dart';
import 'package:watch_store/providers/categoryProvider.dart';
import 'categoryCard.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).categories;
    return SizedBox(
      height: 245,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
          onTap: () => pushNewScreenWithRouteSettings(
            context,
            screen: CategoryScreen(),
            settings: RouteSettings(
                name: CategoryScreen.routeName,
                arguments: categories[index].categoryId),
          ),

          // Navigator.pushNamed(context, CategoryScreen.routeName,
          // arguments: categories[index].categoryId),
          child: CategoryCard(
              catId: categories[index].categoryId.toString(),
              imageUrl: categories[index].imageUrl,
              categoryName: categories[index].categoryType),
        ),
        itemCount: categories.length,
      ),
    );
  }
}
