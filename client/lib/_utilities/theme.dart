import 'package:flutter/material.dart';

import 'constants.dart';

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.grey),
      gapPadding: 10);
  return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder);
}

ThemeData theme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: kBgColor,
    inputDecorationTheme: inputDecorationTheme(),
    // textTheme:
    //     GoogleFonts.robotoCondensedTextTheme(Theme.of(context).textTheme),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
