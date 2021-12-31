import 'package:client/_screens/login/login.dart';
import 'package:client/_screens/signup/signup.dart';
import 'package:client/_utilities/constants.dart';
import 'package:client/_widgets/default_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboardingScreen';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: _size.height * 0.15),
            Center(
              child: Image.asset(
                'assets/images/sports.png',
                width: _size.width * 0.7,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  DefaultButton(
                    text: 'Login',
                    buttonColor: kBorderColor,
                    textColor: kPrimaryColor,
                    press: () {
                      Navigator.restorablePushNamed(
                          context, LoginScreen.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultButton(
                    text: 'SignUp',
                    press: () {
                      Navigator.restorablePushNamed(
                          context, SignUpScreen.routeName);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
