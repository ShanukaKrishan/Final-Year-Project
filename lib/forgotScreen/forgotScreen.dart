import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/widgets/customAppBar.dart';
import 'package:watch_store/widgets/customButtons.dart';
import 'package:watch_store/widgets/utils.dart';

import 'CheckEmailScreen.dart';

class ForgotScreen extends StatefulWidget {
  static String routeName = '/forgotScreen';

  const ForgotScreen({Key? key}) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    super.dispose();
  }

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
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _email,
                      validator: (email) {
                        if (email == "") {
                          return "Please enter a valid email ";
                        } else if (!emailValidatorRegExp.hasMatch(email!)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(hintText: "Email address"),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                CustomButton(
                    buttonText: "Reset email",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        resetPassword();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _email.text.trim());
      Navigator.pushNamed(context, CheckEmailScreen.routeName);
    } on FirebaseAuthException catch (e) {
      Utils.ShowSnackBar(e.message, Colors.red);
      Navigator.pop(context);
    }
  }
}
//Navigator.pushNamed(context, CheckEmailScreen.routeName),
