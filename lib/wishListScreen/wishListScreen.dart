import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/product.dart';
import '../productDetailScreen/productDetailScreen.dart';
import '../providers/productsProvider.dart';
import '../widgets/ProductCard.dart';

class WishListScreen extends StatelessWidget {
  static String routeName = '/wishListScreen';
  const WishListScreen({Key? key}) : super(key: key);

  List<Widget> getFavoriteProducts(List products, BuildContext context) {
    print(products);
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    List<Widget> children = [];
    List<Product> prod = [];
    for (int i = 0; i < products.length; i++) {
      final item =
          productProvider.getProductUsingStringId(products[i].toString());
      prod.add(item);
      children.add(ProductCard(
          id: prod[i].id, title: prod[i].title, imageUrl: prod[i].imageUrl));
      print(item.id);
      print(prod);
      //print("xxxxxxxxxxxxxx");

      // if (products[i].isFavorite) {
      //   GestureDetector(
      //     onTap: () {
      //       // Navigator.pushNamed(context, ProductDetailScreen.routeName,
      //       //     arguments: products[i].id);
      //       pushNewScreenWithRouteSettings(
      //         context,
      //         settings: RouteSettings(
      //             name: ProductDetailScreen.routeName,
      //             arguments: products[i].id),
      //         screen: ProductDetailScreen(),
      //         withNavBar: false,
      //         pageTransitionAnimation: PageTransitionAnimation.cupertino,
      //       );
      //       // Navigator.pushNamed(context, ProductDetailScreen.routeName,
      //       //     arguments: products[i].id);
      //     },
      //     child: ProductCard(
      //         id: products[i].id.toString(),
      //         title: products[i].title,
      //         price: "\$" + products[i].price.toString(),
      //         imageUrl: products[i].imageUrl),
      //   );
      // }
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context, listen: false);

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverAppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Wish List",
                style: kTextAppBarTitle,
              ),
            ),
          ];
        },
        body: FutureBuilder(
            future: productsData.getFavorites(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final products = productsData.favorites;
                return GridView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: getFavoriteProducts(products, context),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: ScreenUtil().setWidth(20),
                      crossAxisCount: 2,
                      childAspectRatio: 0.5),
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
