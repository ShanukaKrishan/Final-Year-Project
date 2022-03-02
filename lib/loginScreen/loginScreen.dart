import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/forgotScreen/forgotScreen.dart';
import 'package:watch_store/registerScreen/registerScreen.dart';
import 'package:watch_store/widgets/customAppBar.dart';
import 'package:watch_store/widgets/customButton.dart';
import 'package:watch_store/widgets/customSocialButton.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    // final kHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          const CustomAppBar(appBarTitle: "LOGIN"),
        ];
      },
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Let's sign you in",
                      style: kHeadingTitle,
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration:
                                const InputDecoration(hintText: "Email"),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(hintText: "Password"),
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 24.h,
                              width: 24.h,
                              child: Checkbox(
                                  activeColor: Colors.black,
                                  value: value,
                                  onChanged: (value) {
                                    setState(() {
                                      this.value = value!;
                                    });
                                  }),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            const Text(
                              "Remember me",
                              style: TextStyle(
                                fontFamily: kSourceSansPro,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, ForgotScreen.routeName),
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontFamily: kSourceSansPro,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    CustomButton(
                      buttonText: "Sign In",
                      press: () {},
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    const SocialButton(
                        icon: FontAwesomeIcons.google,
                        buttonText: "Sign in with Google"),
                    SizedBox(
                      height: 20.h,
                    ),
                    const SocialButton(
                        icon: FontAwesomeIcons.facebookF,
                        buttonText: "Sign in with Facebook"),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, RegisterScreen.routeName),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
