import 'package:client/_screens/login/login.dart';
import 'package:client/_utilities/constants.dart';
import 'package:flutter/material.dart';

class AlreadyHave extends StatelessWidget {
  const AlreadyHave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
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
            Navigator.pushNamed(context, LoginScreen.routeName);
          },
          child: Text(
            'Login',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
