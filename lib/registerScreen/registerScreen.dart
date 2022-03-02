import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:watch_store/loginScreen/loginScreen.dart';
import 'package:watch_store/widgets/customAppBar.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/widgets/customButton.dart';
import 'package:watch_store/widgets/customSocialButton.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = '/registerScreen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const CustomAppBar(appBarTitle: "REGISTER"),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 18.w),
            child: Column(
              children: <Widget>[
                const Text(
                  "Create your account",
                  style: kHeadingTitle,
                ),
                Text(
                  "Join a community of over 200k people!",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const SizedBox(height: 30),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration:
                              const InputDecoration(hintText: "Username"),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(hintText: "Email"),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              const InputDecoration(hintText: "Password"),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(hintText: "Phone"),
                        ),
                        const SizedBox(height: 40),
                        CustomButton(
                          buttonText: "Sign Up",
                          press: () {},
                        ),
                        const SizedBox(height: 20),
                        const SocialButton(
                            icon: FontAwesomeIcons.google,
                            buttonText: "Continue with Google"),
                        const SizedBox(height: 20),
                        const SocialButton(
                            icon: FontAwesomeIcons.facebookF,
                            buttonText: "Continue with Facebook"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, LoginScreen.routeName),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
