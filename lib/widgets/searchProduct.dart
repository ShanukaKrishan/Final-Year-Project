import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../productDetailScreen/productDetailScreen.dart';
import '../providers/productsProvider.dart';
import 'commonProductCard.dart';

class SearchItem extends SearchDelegate<Product> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
        textTheme: const TextTheme(
            headline6: TextStyle(
          color: Colors.white,
        )),
        inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            hintStyle: TextStyle(
              color: Colors.white,
            )));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {}, icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.navigate_before));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final loadedProducts = Provider.of<ProductsProvider>(context).items;
    final listItem = query.isEmpty
        ? loadedProducts
        : loadedProducts
            .where((product) =>
                product.title.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return listItem.isEmpty
        ? const Center(child: Text("No product found :("))
        : GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            shrinkWrap: true,
            itemCount: listItem.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 0,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (ctx, i) => InkWell(
                onTap: () {
                  pushNewScreenWithRouteSettings(context,
                      screen: ProductDetailScreen(),
                      withNavBar: false,
                      settings: RouteSettings(
                          arguments: loadedProducts[i].id.toString()));
                },
                child: CommonProduct(
                  title: listItem[i].title,
                  imageUrl: listItem[i].imageUrl,
                  price: listItem[i].price.toString(),
                )),
          );
  }
}
