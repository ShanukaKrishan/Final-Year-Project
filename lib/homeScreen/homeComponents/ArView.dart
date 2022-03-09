import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../productDetailScreen/productDetailScreen.dart';
import '../../providers/productsProvider.dart';
import '../../widgets/ProductCard.dart';

class ArView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = productsData.items;
    return GridView(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: getArProducts(products, context),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: ScreenUtil().setWidth(20),
          crossAxisCount: 2,
          childAspectRatio: 0.5),
    );
  }

  List<Widget> getArProducts(List products, BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < products.length; i++) {
      if (products[i].isAr) {
        children.add(
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailScreen.routeName,
                  arguments: products[i].id);
            },
            child: ProductCard(
                id: products[i].id.toString(),
                title: products[i].title,
                imageUrl: products[i].imageUrl),
          ),
        );
        const SizedBox(height: 10);
      }
    }
    return children;
  }
}
