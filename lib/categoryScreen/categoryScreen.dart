import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:watch_store/homeScreen/homeComponents/categoryCard.dart';
import 'package:watch_store/models/product.dart';
import 'package:watch_store/productDetailScreen/productDetailScreen.dart';
import 'package:watch_store/providers/categoryProvider.dart';
import 'package:watch_store/providers/productsProvider.dart';
import 'package:watch_store/widgets/commonProductCard.dart';
import 'package:watch_store/widgets/customAppBar.dart';
import 'package:watch_store/widgets/widgetAppBar.dart';

class CategoryScreen extends StatelessWidget {
  final String? appBarTitle;
  static String routeName = '/categoryScreen';
  const CategoryScreen({Key? key, this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String catId = ModalRoute.of(context)!.settings.arguments as String;
    final cat = Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryUsingId(catId);
    final products =
        Provider.of<ProductsProvider>(context, listen: false).items;
    final catProducts = products
        .where((element) => element.categoryId == cat.categoryId)
        .toList();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: WidgetAppBar(appBarTitle: cat.categoryType),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: catProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (ctx, i) => InkWell(
                  onTap: () => pushNewScreenWithRouteSettings(context,
                      screen: ProductDetailScreen(),
                      withNavBar: false,
                      settings: RouteSettings(
                        arguments: catProducts[i].id,
                      )),
                  child: CommonProduct(
                      imageUrl: catProducts[i].imageUrl,
                      title: catProducts[i].title,
                      price: catProducts[i].price.toString()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
