import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:watch_store/allProductScreen/allProductScreen.dart';
import 'package:watch_store/cartScreen/cartScreen.dart';
import 'package:watch_store/homeScreen/homeComponents/carouselWidget.dart';
import 'package:watch_store/models/catergory.dart';
import 'package:watch_store/productDetailScreen/productDetailScreen.dart';
import 'package:watch_store/providers/categoryProvider.dart';
import 'package:watch_store/providers/productsProvider.dart';
import 'package:watch_store/widgets/ProductCard.dart';
import 'package:watch_store/widgets/searchProduct.dart';

import '../categoryScreen/categoryScreen.dart';
import '../constants.dart';
import 'package:provider/provider.dart';
import '../providers/cartProvider.dart';
import '../widgets/commonProductCard.dart';
import 'homeComponents/ArView.dart';
import 'homeComponents/CategoryView.dart';
import 'homeComponents/featuredProduct.dart';
import 'homeComponents/homeContentHeading.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:watch_store/widgets/customDrawer.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late Function addItem;
  // void sendData() {
  //   final cart = Provider.of<CartProvider>(context, listen: false);
  //   var total = cart.totalAmount;
  //   var params = jsonEncode({"total:": total});
  //   AlanVoice.callProjectApi("script::getTotal", params);
  // }
  //
  // _HomeScreenState() {
  //   AlanVoice.addButton(
  //       "6c32a6cd03dda31fa16776e42b7ae7642e956eca572e1d8b807a3e2338fdd0dc/stage",
  //       buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
  //   AlanVoice.onCommand.add((command) => _handleCommand(command.data));
  // }
  //
  // void _handleCommand(Map<String, dynamic> command) {
  //   switch (command['command']) {
  //     case "forward":
  //       pushNewScreen(context, screen: const CartScreen(), withNavBar: false);
  //       break;
  //
  //     case "add":
  //       final cart = Provider.of<CartProvider>(context, listen: false);
  //       final product = Provider.of<ProductsProvider>(context, listen: false);
  //       final id = command['id'];
  //
  //       final loadProduct = product.getProductUsingId(id);
  //       cart.addItem(loadProduct.id.toString(), loadProduct.price.toDouble(),
  //           loadProduct.title, loadProduct.imageUrl, context);
  //       sendData;
  //       // Navigator.pushNamed(context, CartScreen.routeName);
  //       break;
  //
  //     default:
  //       debugPrint("Unknown command");
  //   }
  // }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final provider = Provider.of<ProductsProvider>(context, listen: false);
      final category = Provider.of<CategoryProvider>(context, listen: false);
      await provider.getProductsFromFirebase();
      await category.getCategoriesFromFirebase();
      // await provider.getFavorites();
    });
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      key: _drawerKey,
      drawer: const AppDrawer(),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "HOME",
                style: kTextAppBarTitle,
              ),
              leading: IconButton(
                onPressed: () {
                  _drawerKey.currentState?.openDrawer();
                },
                icon: const FaIcon(
                  FontAwesomeIcons.bars,
                  size: 18,
                ),
              ),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: SearchItem());
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.search,
                      size: 18,
                    )),
              ],
            )
          ];
        },
        body: Consumer<ProductsProvider>(builder: (context, provider, child) {
          if (provider.productsFetching) {
            return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          }
          return Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            "Collection of luxury",
                            style: kHeadingTitle,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Find the perfect watch for your need",
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    const ContentHeading(
                      mainHeading: "AR Try-On",
                      screen: 'allProducts',
                    ),
                    const SizedBox(height: 20),
                    ArView(),
                    const ContentHeading(
                      mainHeading: "Categories",
                      screen: 'categoryScreen',
                    ),
                    const SizedBox(height: 20),
                    CategoryView(),

                    const SizedBox(height: 25),
                    const ContentHeading(
                      mainHeading: "Top deals",
                      screen: 'allProducts',
                    ),
                    const SizedBox(height: 15),
                    const CustomCarouselSlider(),
                    const SizedBox(height: 25),
                    const ContentHeading(
                      mainHeading: "Featured products",
                      screen: 'allProducts',
                    ),
                    const SizedBox(height: 20),
                    const FeaturedProductView(),

                    // ElevatedButton(
                    //     onPressed: () => FirebaseAuth.instance.signOut(),
                    //     child: const Text("Sign out"))
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
