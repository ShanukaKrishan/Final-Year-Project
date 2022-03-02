import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/constants.dart';
import 'package:watch_store/widgets/customAppBar.dart';
import 'package:pinput/pinput.dart';
import 'package:watch_store/widgets/customButton.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();

  @override
  String toStringShort() => 'With Bottom Cursor';
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const CustomAppBar(appBarTitle: "PHONE RESET"),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Enter the 4 digit code sent to:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontFamily: kDMSerifDisplay),
                ),
                const Text(
                  "1 222 444 555 99",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 22,
                      fontFamily: kDMSerifDisplay),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter the 4 digit code that was sent to the register phone number for security purpose",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: kSourceSansPro,
                      color: Colors.grey.shade500),
                ),
                const SizedBox(height: 40),
                Pinput(
                  pinAnimationType: PinAnimationType.slide,
                  cursor: cursor,
                  obscureText: true,
                  preFilledWidget: preFilledWidget,
                  defaultPinTheme: defaultPinTheme,
                  onCompleted: (pin) => print(pin),
                ),
                const SizedBox(height: 120),
                const Text("Didn't receive the SMS? "),
                const SizedBox(height: 20),
                CustomButton(buttonText: "Request new code", press: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }

  final cursor = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  final defaultPinTheme = const PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontFamily: kSourceSansPro, fontSize: 17),
    decoration: BoxDecoration(),
  );
  final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );
}
