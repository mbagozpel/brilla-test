import 'package:client/_utilities/constants.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String text}) {
  final SnackBar snackBar = SnackBar(
    content: Text(text),
    backgroundColor: kPrimaryColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
