import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:watch_store/3DViewProductDetailScreen/3DViewScreen.dart';

import '../../productDetailScreen/productDetailScreen.dart';
import '../../providers/productsProvider.dart';
import '../../widgets/ProductCard.dart';

class ArView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context).arItems;

    return GridView(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: getArProducts(productsData, context),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: ScreenUtil().setWidth(20),
          crossAxisCount: 2,
          childAspectRatio: 0.5),
    );
  }

  List<Widget> getArProducts(List products, BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < products.length; i++) {
      children.add(
        GestureDetector(
          onTap: () {
            pushNewScreenWithRouteSettings(context,
                screen: ARViewScreen(),
                withNavBar: false,
                settings: RouteSettings(
                    name: ARViewScreen.routeName,
                    arguments: products[i].id.toString()));
          },
          child: ProductARCard(
            id: products[i].id.toString(),
            title: products[i].title,
            imageUrl: products[i].imageUrl,
            price: '\$' + products[i].price.toString(),
          ),
        ),
      );
    }
    return children;
  }
}
