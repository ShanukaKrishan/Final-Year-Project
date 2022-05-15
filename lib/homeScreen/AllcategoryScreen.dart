import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:watch_store/categoryScreen/categoryScreen.dart';
import 'package:watch_store/homeScreen/homeComponents/categoryCard.dart';

import '../constants.dart';
import '../providers/categoryProvider.dart';
import '../providers/productsProvider.dart';
import '../widgets/commonProductCard.dart';

class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({Key? key}) : super(key: key);
  static String routeName = '/categoryScreen';
  @override
  Widget build(BuildContext context) {
    final categories =
        Provider.of<CategoryProvider>(context, listen: false).categories;
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return const <Widget>[
            SliverAppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Categories",
                style: kTextAppBarTitle,
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (ctx, i) => InkWell(
                  onTap: () => pushNewScreenWithRouteSettings(context,
                      screen: const CategoryScreen(),
                      settings: RouteSettings(
                          name: CategoryScreen.routeName,
                          arguments: categories[i].categoryId)),
                  child: CategoryCard(
                      imageUrl: categories[i].imageUrl,
                      categoryName: categories[i].categoryType,
                      catId: categories[i].categoryId),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
