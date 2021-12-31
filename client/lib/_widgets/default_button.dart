import 'package:client/_utilities/constants.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? textColor;
  final String text;
  final VoidCallback press;
  const DefaultButton(
      {Key? key,
      this.buttonColor = kPrimaryColor,
      this.textColor = kBgColor,
      required this.press,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return MaterialButton(
      onPressed: press,
      minWidth: double.infinity,
      height: _size.height * 0.08,
      color: buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(text,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: textColor)),
    );
  }
}
