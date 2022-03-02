import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/constants.dart';
import 'package:ripple_animation/ripple_animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:watch_store/widgets/customButton.dart';

import '../loginScreen/loginScreen.dart';

class CheckEmailScreen extends StatefulWidget {
  static String routeName = '/checkEmailScreen';
  const CheckEmailScreen({Key? key}) : super(key: key);

  @override
  _CheckEmailScreenState createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 100),
          Container(
            width: double.infinity,
            child: const RippleAnimation(
              repeat: true,
              color: kPrimaryColor,
              minRadius: 50,
              ripplesCount: 6,
              child: Icon(
                FontAwesomeIcons.solidPaperPlane,
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
              "We've sent you instructions on how to reset your password",
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
              buttonText: "Back to Login",
              press: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              })
        ],
      ),
    );
  }
}
