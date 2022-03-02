import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: kSourceSansPro,
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    inputDecorationTheme: inputDecorationTheme(),
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor),
    ),
  );
}
