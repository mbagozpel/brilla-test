import 'package:client/_controllers/account_controller.dart';
import 'package:client/_utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class InputPhoneNumber extends StatelessWidget {
  InputPhoneNumber({Key? key}) : super(key: key);
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AccountController _controller = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: InternationalPhoneNumberInput(
        initialValue: PhoneNumber(isoCode: 'NG'),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        onInputChanged: (number) {
          _controller.phoneNumber.value = number.phoneNumber!;
        },
        selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
        keyboardType: TextInputType.number,
        selectorTextStyle: Theme.of(context).textTheme.headline6,
        textStyle: Theme.of(context).textTheme.headline6,
        spaceBetweenSelectorAndTextField: 0,
        inputDecoration: InputDecoration(
          isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kBorderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        searchBoxDecoration: const InputDecoration(
            hintText: 'Search Country',
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            suffixIcon: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.search),
            )),
      ),
    );
  }
}
