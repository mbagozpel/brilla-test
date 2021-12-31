import 'package:client/_controllers/account_controller.dart';
import 'package:client/_screens/login/forgot_password.dart';
import 'package:client/_screens/phone_verification/phone_verification.dart';
import 'package:client/_screens/signup/signup.dart';
import 'package:client/_utilities/constants.dart';
import 'package:client/_widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormWidget extends StatelessWidget {
  FormWidget({Key? key}) : super(key: key);
  final AccountController _controller = Get.put(AccountController());
  static final _key = GlobalKey<FormState>(debugLabel: '/formWidget');
  String password = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            autocorrect: true,
            validator: (value) {
              if (value!.isEmpty) {
                return kEmailNullError;
              }
              if (!emailValidatorRegExp.hasMatch(value)) {
                return kInvalidEmailError;
              }

              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onSaved: (value) {
              email = value!.trim();
            },
            decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.email,
                  color: kPrimaryColor,
                ),
                hintText: 'Enter your email',
                labelText: 'Email'),
          ),
          SizedBox(
            height: _size.height * 0.04,
          ),
          Obx(() => TextFormField(
                autocorrect: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return kPassNullError;
                  }
                },
                obscureText: _controller.isVisible.value,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: (value) {
                  password = value!.trim();
                },
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _controller.isVisible.toggle();
                      },
                      child: _controller.isVisible.isFalse
                          ? const Icon(
                              Icons.visibility,
                              color: kPrimaryColor,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: kPrimaryColor,
                            ),
                    ),
                    hintText: 'Enter your password',
                    labelText: 'Password'),
              )),
          SizedBox(
            height: _size.height * 0.04,
          ),
          GestureDetector(
            onTap: () {
              Navigator.restorablePushNamed(context, ResetPassword.routeName);
            },
            child: Text(
              'Forgot password?',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: kPrimaryColor),
            ),
          ),
          SizedBox(
            height: _size.height * 0.02,
          ),
          Obx(() => _controller.isLoading.isTrue
              ? const CircularProgressIndicator()
              : DefaultButton(
                  text: 'Login',
                  press: () {
                    bool isValid = _key.currentState!.validate();

                    if (isValid) {
                      _key.currentState!.save();
                      _controller.loginUser(
                        context: context,
                        email: email,
                        password: password,
                      );
                    } else {
                      return;
                    }
                  })),
          SizedBox(
            height: _size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.restorablePushNamed(
                      context, SignUpScreen.routeName);
                },
                child: Text(
                  'SignUp',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: kPrimaryColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: _size.height * 0.04,
          ),
          Text(
            'OR',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(),
          ),
          SizedBox(
            height: _size.height * 0.02,
          ),
          DefaultButton(
            press: () {
              Navigator.pushNamed(context, VerificationScreen.routeName);
            },
            text: 'Login with Mobile',
            textColor: kPrimaryColor,
            buttonColor: kBorderColor,
          )
        ],
      ),
    );
  }
}
