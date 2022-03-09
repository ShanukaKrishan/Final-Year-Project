import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:watch_store/homeScreen/homeComponents/carouselWidget.dart';
import 'package:watch_store/models/catergory.dart';
import 'package:watch_store/productDetailScreen/productDetailScreen.dart';
import 'package:watch_store/widgets/ProductCard.dart';

import '../constants.dart';
import 'package:provider/provider.dart';
import 'homeComponents/ArView.dart';
import 'homeComponents/CategoryView.dart';
import 'homeComponents/featuredProduct.dart';
import 'homeComponents/homeContentHeading.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryType> categories = [
    CategoryType(
        categoryType: "Leather Strap",
        categoryId: 1,
        categoryImageUrl: "assets/images/black-watch.jpg"),
    CategoryType(
        categoryType: "Metallic Strap",
        categoryId: 2,
        categoryImageUrl: "assets/images/black-dial-silver-watch.jpg"),
    CategoryType(
        categoryType: "Smart Watch",
        categoryId: 3,
        categoryImageUrl: "assets/images/smart-watch.jpg"),
  ];
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: Drawer(),
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
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.search,
                      size: 18,
                    )),
              ],
            )
          ];
        },
        body: Container(
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
                  const ContentHeading(mainHeading: "Categories"),
                  const SizedBox(height: 20),
                  CategoryView(categories: categories),

                  const SizedBox(height: 25),
                  const ContentHeading(mainHeading: "Top deals"),
                  const SizedBox(height: 15),
                  const CustomCarouselSlider(),
                  const SizedBox(height: 25),
                  const ContentHeading(mainHeading: "Featured products"),
                  const SizedBox(height: 20),
                  const FeaturedProductView(),

                  const ContentHeading(mainHeading: "AR Try-On"),
                  const SizedBox(height: 20),
                  ArView(),
                  const ContentHeading(mainHeading: "AR Try-On"),

                  // ElevatedButton(
                  //     onPressed: () => FirebaseAuth.instance.signOut(),
                  //     child: const Text("Sign out"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
