import 'package:client/_utilities/constants.dart';
import 'package:flutter/material.dart';

import 'settings_form.dart';

class ProfileSettings extends StatelessWidget {
  static const routeName = '/profilesettings';
  const ProfileSettings({Key? key}) : super(key: key);

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
            'Settings',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.grey),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: _size.height * 0.06,
              ),
              Text(
                'Update Profile',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                'Change your email and username',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey),
              ),
              SettingsForm(),
            ],
          ),
        ));
  }
}
