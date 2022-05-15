import 'dart:convert';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:watch_store/cartScreen/cartScreen.dart';
import 'package:watch_store/constants.dart';
import 'package:provider/provider.dart';

import 'package:watch_store/widgets/cartBadge.dart';
import 'package:watch_store/providers/cartProvider.dart';
import 'package:watch_store/providers/productsProvider.dart';

class ProductDetailScreen extends StatefulWidget {
  static String routeName = "/detailScreen";

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: true)
        .getProductUsingStringId(productId);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: true);

    bool isFavorite = false;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: const Color.fromRGBO(235, 235, 235, 1),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40.h,
                        width: 40.w,
                        child: FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      const Text(
                        "PRODUCT DETAILS",
                        style: TextStyle(
                            fontFamily: kDMSerifDisplay, fontSize: 18),
                      ),
                      Consumer<CartProvider>(
                        builder: (_, cartData, ch) => CartBadge(
                            child: ch!,
                            value: cartData.itemCount == 0
                                ? 0.toString()
                                : cartData.itemCount.toString(),
                            color: kPrimaryColor),
                        child: IconButton(
                          icon: const Icon(Icons.shopping_bag_outlined),
                          onPressed: () {
                            pushNewScreen(context,
                                screen: const CartScreen(), withNavBar: false);
                            // Navigator.pushNamed(
                            //   context,
                            //   CartScreen.routeName,
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AspectRatio(
                  aspectRatio: 1.5,
                  child: CachedNetworkImage(imageUrl: loadedProduct.imageUrl)),
              Container(
                padding: EdgeInsets.only(top: 20.w),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Color.fromRGBO(250, 250, 250, 1),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      loadedProduct.title,
                      style: kHeadingTitle,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "This watch is nine-millimeter thick steal, forty meters in diamater with 403L polished case that is in silver",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontFamily: kSourceSansPro,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "\$" + loadedProduct.price.toString(),
                      style: const TextStyle(
                          color: kPrimaryColor,
                          fontFamily: kDMSerifDisplay,
                          fontSize: 30),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: 20,
                                onPressed: () {
                                  setState(() {
                                    loadedProduct
                                        .togleFavoriteStatus(productId);
                                  });
                                },
                                icon: loadedProduct.isFavorite
                                    ? const Icon(FontAwesomeIcons.solidBookmark,
                                        color: kPrimaryColor)
                                    : const Icon(
                                        FontAwesomeIcons.solidBookmark),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: kPrimaryColor,
                              fixedSize: const Size(200, 50),
                            ),
                            onPressed: () {
                              // addProductCart(loadedProduct.id,
                              //     loadedProduct.price.toDouble());

                              sendData();
                              cart.addItem(
                                  loadedProduct.id.toString(),
                                  loadedProduct.price.toDouble(),
                                  loadedProduct.title,
                                  loadedProduct.imageUrl,
                                  context);
                            },
                            child: const Text(
                              "Add to cart",
                              style: TextStyle(fontFamily: kDMSerifDisplay),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: 20,
                                onPressed: () async {
                                  await LaunchApp.openApp(
                                    androidPackageName:
                                        'com.DefaultCompany.test1',
                                  );
                                },
                                icon: const Icon(FontAwesomeIcons.vrCardboard),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // AppListItem(onClick: listClick, index: 1),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendData() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    var total = cart.totalAmount;
    var params = jsonEncode({"total:": total});
    AlanVoice.callProjectApi("script::getTotal", params);
  }

  Future<void> addProductCart(String loadedProductID, double price) async {
    final userID = await FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('userCart')
        .add({
      'productId': loadedProductID,
      'price': price,
    });
  }
}
