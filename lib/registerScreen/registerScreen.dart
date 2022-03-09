import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:watch_store/loginScreen/loginScreen.dart';
import 'package:watch_store/main.dart';
import 'package:watch_store/widgets/customAppBar.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/widgets/customButtons.dart';
import 'package:watch_store/widgets/customSocialButton.dart';
import 'package:watch_store/widgets/utils.dart';
import 'package:watch_store/widgets/verifyEmailScreen.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = '/registerScreen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

bool isObscureText = true;

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  bool showSpinner = false;
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
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: const CircularProgressIndicator(
            color: Colors.black,
          ),
          child: SingleChildScrollView(
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
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Username can't be empty";
                              } else if (value.length < 4) {
                                return "Username can't be less than 4 characters";
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: "Username"),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return " Email can't be empty";
                              } else if (!emailValidatorRegExp
                                  .hasMatch(value)) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: "Email"),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            obscureText: isObscureText,
                            validator: (value) {
                              if (value == "") {
                                return "Password can't be empty";
                              } else if (value!.length < 4) {
                                return "Password can't be less than 4 characters";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isObscureText = !isObscureText;
                                  });
                                  FocusScope.of(context).unfocus();
                                },
                                child: const Icon(
                                  Icons.visibility,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == "") {
                                return "Phone can't be empty";
                              } else if (value!.length < 4) {
                                return "Phone can't be less than 4 characters";
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: "Phone"),
                          ),
                          const SizedBox(height: 40),
                          CustomButton(
                            buttonText: "Sign Up",
                            press: signUp,
                            // if (_formKey.currentState!.validate()) {
                            //   setState(() {
                            //     showSpinner = true;
                            //   });
                            //   signUp();
                            // }
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;
    setState(() {
      showSpinner = true;
    });

    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      print(result.user!.uid);
      Navigator.pushNamed(context, VerifyEmailScreen.routeName);
      setState(() {
        showSpinner = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        showSpinner = false;
      });
      Utils.ShowSnackBar(e.message, Colors.red);
    }
  }
}
