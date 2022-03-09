import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/forgotScreen/forgotScreen.dart';
import 'package:watch_store/main.dart';

import 'package:watch_store/registerScreen/registerScreen.dart';
import 'package:watch_store/widgets/customAppBar.dart';
import 'package:watch_store/widgets/customButtons.dart';
import 'package:watch_store/widgets/customSocialButton.dart';
import 'package:watch_store/widgets/utils.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool value = false;
  bool showSpinner = false;
  bool isObscureText = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Utils.ShowSnackBar(e.message, Colors.red);
      setState(() {
        showSpinner = false;
      });
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
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
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email can't be empty";
                                } else if (!emailValidatorRegExp
                                    .hasMatch(value)) {
                                  return "Enter a valid email";
                                }
                                return null;
                              },
                              decoration:
                                  const InputDecoration(hintText: "Email"),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password can't be empty";
                                }
                                return null;
                              },
                              obscureText: isObscureText,
                              decoration: InputDecoration(
                                hintText: "Password",
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      isObscureText = !isObscureText;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: kPrimaryColor,
                          fixedSize: const Size(250, 50),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              showSpinner = true;
                            });
                            signIn();
                          }
                        },
                        child: showSpinner == true
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text("Sign In"),
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
      ),
    );
  }
}
