import 'package:client/_controllers/account_controller.dart';
import 'package:client/_utilities/constants.dart';
import 'package:client/_widgets/default_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatelessWidget {
  ForgotPasswordForm({Key? key}) : super(key: key);
  final _passwordKey = GlobalKey<FormState>();
  final AccountController _controller = AccountController();
  String code = '';
  String newPassword = '';

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Form(
      key: _passwordKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: _size.height * 0.06,
            ),
            TextFormField(
              autocorrect: true,
              decoration: const InputDecoration(
                  labelText: 'Code', hintText: 'Enter code'),
              onSaved: (value) {
                code = value!.trim();
              },
            ),
            SizedBox(
              height: _size.height * 0.04,
            ),
            TextFormField(
              autocorrect: true,
              decoration: const InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter you new password'),
              validator: (value) {
                if (value!.isEmpty) return kPassNullError;

                if (value.length < 8) return kShortPassError;

                return null;
              },
              onSaved: (value) {
                newPassword = value!.trim();
              },
            ),
            SizedBox(height: _size.height * 0.06),
            DefaultButton(
              text: 'Continue',
              press: () {
                bool isValid = _passwordKey.currentState!.validate();

                if (isValid) {
                  _passwordKey.currentState!.save();
                  _controller.confirmCode(
                      code: code, newPassword: newPassword, context: context);
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
