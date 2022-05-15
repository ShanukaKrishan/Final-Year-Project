import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:watch_store/allProductScreen/allProductScreen.dart';
import 'package:watch_store/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:watch_store/homeScreen/AllcategoryScreen.dart';

class ContentHeading extends StatelessWidget {
  final String mainHeading;
  final String screen;

  const ContentHeading({
    Key? key,
    required this.mainHeading,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          mainHeading,
          style: kSubTitle,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                switch (screen) {
                  case 'allProducts':
                    pushNewScreen(context, screen: const AllProductScreen());
                    break;
                  case 'categoryScreen':
                    pushNewScreen(context, screen: const AllCategoryScreen());
                }
              },
              child: const Text(
                "See all",
                style: TextStyle(fontSize: 16, color: kPrimaryColor),
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(3),
            ),
            const Icon(
              FontAwesomeIcons.angleDoubleRight,
              size: 14,
              color: kPrimaryColor,
            ),
          ],
        )
      ],
    );
  }
}
