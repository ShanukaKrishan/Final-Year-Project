import 'package:flutter/material.dart';
import 'package:watch_store/constants.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function? press;

  // ignore: use_key_in_widget_constructors
  const CustomButton({required this.buttonText, required this.press});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: kPrimaryColor,
        fixedSize: const Size(250, 50),
      ),
      onPressed: press as void Function()?,
      child: Text(
        buttonText,
        style: TextStyle(fontFamily: kDMSerifDisplay),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final String buttonText;
  final Function? press;
  final IconData icon;

  // ignore: use_key_in_widget_constructors
  const CustomIconButton(
      {required this.buttonText, required this.press, required this.icon});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: kPrimaryColor,
        fixedSize: const Size(250, 50),
      ),
      onPressed: press as void Function()?,
      label: Text(
        buttonText,
        style: const TextStyle(fontFamily: kSourceSansPro),
      ),
    );
  }
}
