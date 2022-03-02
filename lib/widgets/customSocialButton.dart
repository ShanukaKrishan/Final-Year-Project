import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String buttonText;
  // ignore: use_key_in_widget_constructors
  const SocialButton({required this.icon, required this.buttonText});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          elevation: 0, primary: Colors.black, fixedSize: const Size(250, 50)),
      onPressed: () {},
      icon: FaIcon(icon),
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Text(buttonText),
      ),
    );
  }
}
