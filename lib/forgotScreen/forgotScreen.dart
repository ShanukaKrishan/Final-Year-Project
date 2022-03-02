import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/widgets/customAppBar.dart';
import 'package:watch_store/widgets/customButton.dart';

import 'CheckEmailScreen.dart';

class ForgotScreen extends StatelessWidget {
  static String routeName = '/forgotScreen';
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const CustomAppBar(appBarTitle: "RESET PASSWORD"),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                const Text(
                  "Forgot your password?",
                  style: kHeadingTitle,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 16.h),
                  child: Text(
                      "Enter your email address and we will we send you a link to reset your password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: kSourceSansPro,
                          fontSize: 15,
                          color: Colors.grey.shade600)),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(hintText: "Email address"),
                  ),
                ),
                const SizedBox(height: 70),
                CustomButton(
                    buttonText: "Reset email",
                    press: () {
                      Navigator.pushNamed(context, CheckEmailScreen.routeName);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//Navigator.pushNamed(context, CheckEmailScreen.routeName),
