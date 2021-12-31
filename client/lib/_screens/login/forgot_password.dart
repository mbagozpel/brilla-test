import 'package:client/_controllers/account_controller.dart';
import 'package:client/_utilities/constants.dart';
import 'package:client/_widgets/default_button.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  static const routeName = '/resetPassword';
  ResetPassword({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final AccountController _controller = AccountController();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: kPrimaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Login',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.grey),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: _size.height * 0.1,
              ),
              Text(
                'Password Reset',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                'A mail with password-reset link will be sent to your email',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey),
              ),
              SizedBox(
                height: _size.height * 0.1,
              ),
              TextFormField(
                  key: const ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autocorrect: true,
                  decoration: const InputDecoration(
                      hintText: 'Enter your email', labelText: 'Email'),
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) return kEmailNullError;

                    if (!emailValidatorRegExp.hasMatch(value)) {
                      return kInvalidEmailError;
                    }

                    return null;
                  }),
              SizedBox(
                height: _size.height * 0.06,
              ),
              DefaultButton(
                  text: 'Send code',
                  press: () {
                    _controller.sendPasswordReset(
                        email: _emailController.text.trim(), context: context);
                  }),
            ],
          ),
        ));
  }
}
