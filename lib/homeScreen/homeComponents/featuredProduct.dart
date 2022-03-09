import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:watch_store/providers/productsProvider.dart';

import '../../productDetailScreen/productDetailScreen.dart';
import '../../widgets/ProductCard.dart';

class FeaturedProductView extends StatelessWidget {
  const FeaturedProductView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context, listen: false);
    final products = productsData.items;
    return GridView(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: getFeaturedProducts(products, context),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: ScreenUtil().setWidth(20),
          crossAxisCount: 2,
          childAspectRatio: 0.5),
    );
  }

  List<Widget> getFeaturedProducts(List products, BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < products.length; i++) {
      if (products[i].isFeatured) {
        children.add(
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailScreen.routeName,
                  arguments: products[i].id);
            },
            child: ProductCard(
                id: products[i].id.toString(),
                title: products[i].title,
                price: "\$" + products[i].price.toString(),
                imageUrl: products[i].imageUrl),
          ),
        );
        const SizedBox(height: 10);
      }
    }
    return children;
  }
}
