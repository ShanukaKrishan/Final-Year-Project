import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../widgets/customAppBar.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: () {},
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Categories ",
                    style: kSubTitle,
                  ),
                  Row(
                    children: [
                      Text(
                        "See all",
                        style: TextStyle(fontSize: 16, color: kPrimaryColor),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(3),
                      ),
                      Icon(
                        FontAwesomeIcons.angleDoubleRight,
                        size: 14,
                        color: kPrimaryColor,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
