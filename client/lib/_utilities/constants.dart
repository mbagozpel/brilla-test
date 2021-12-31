import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFF27121);
const kBottomNavBgColor = Color(0xFFF3F3F3);
const kInactiveColor = Color(0xFFADAFBB);
const kBgColor = Colors.white;
const kBorderColor = Color(0xFFE8E6EA);

// UnderlineInputBorder underlineInputBorder() {
//   return UnderlineInputBorder(
//     borderRadius: BorderRadius.circular(radius)
//   )
// }

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please enter an E-mail address";
const String kInvalidEmailError = "Please enter a valid E-mail address";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Enter a password greater that 8 chars";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please enter your full names";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
