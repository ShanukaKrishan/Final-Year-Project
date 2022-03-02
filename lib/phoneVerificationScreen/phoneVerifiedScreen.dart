import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ripple_animation/ripple_animation.dart';
import 'package:watch_store/loginScreen/loginScreen.dart';
import 'package:watch_store/widgets/customButton.dart';

import '../constants.dart';

class PhoneVerified extends StatelessWidget {
  const PhoneVerified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Container(
            width: double.infinity,
            child: const RippleAnimation(
              repeat: true,
              color: kPrimaryColor,
              minRadius: 50,
              ripplesCount: 6,
              child: Icon(
                FontAwesomeIcons.check,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(100),
          ),
          const Text(
            "Check your email",
            style: kHeadingTitle,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Text(
              "Congratulations, your phone has been verified. You can start using the app",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: kSourceSansPro,
                  color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomButton(
              buttonText: "Continue",
              press: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              })
        ],
      ),
    );
  }
}
