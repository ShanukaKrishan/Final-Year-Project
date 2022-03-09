import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:ripple_animation/ripple_animation.dart';

import 'package:watch_store/main.dart';
import 'package:watch_store/widgets/utils.dart';

import '../constants.dart';
import 'customButtons.dart';

class VerifyEmailScreen extends StatefulWidget {
  static String routeName = '/verifyEmailScreen';
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? countdown;
  bool canResendEmail = false;
  @override
  void dispose() {
    timer?.cancel();
    countdown?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    startTimer();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      print("sent");
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 30));
      setState(
        () {
          canResendEmail = true;
        },
      );
    } catch (e) {
      print("error");
    }
  }

  void startTimer() {
    countdown = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (seconds > 0) {
          setState(
            () {
              seconds--;
            },
          );
        } else {
          stopTimer();
        }
      },
    );
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const StartPoint()
        : Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                const SizedBox(
                  width: double.infinity,
                  child: RippleAnimation(
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
                  "Verify your email",
                  style: kHeadingTitle,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Text(
                    "A verification email has been sent to your email.",
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
                CustomIconButton(
                    buttonText: canResendEmail
                        ? "Resend Email"
                        : "Please wait " + buildTime(),
                    press: canResendEmail
                        ? () {
                            sendVerificationEmail();
                            startTimer();
                          }
                        : null,
                    icon: Icons.email_rounded),
              ],
            ),
          );
  }

  String buildTime() {
    return seconds.toString();
  }
}
