import 'package:client/_controllers/account_controller.dart';
import 'package:client/_screens/settings/change_password.dart';
import 'package:client/_screens/settings/profile_settings.dart';
import 'package:client/_utilities/constants.dart';
import 'package:flutter/material.dart';

class SettingsPrivacy extends StatelessWidget {
  SettingsPrivacy({Key? key}) : super(key: key);
  final AccountController _controller = AccountController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsTile(
          title: 'Profile',
          subtitle: 'Manage your profile details',
          icon: Icons.person,
          press: () {
            Navigator.restorablePushNamed(context, ProfileSettings.routeName);
          },
        ),
        SettingsTile(
          title: 'Security',
          subtitle: 'Change your password',
          icon: Icons.warning_rounded,
          press: () {
            Navigator.restorablePushNamed(context, ChangePassword.routeName);
          },
        ),
        SettingsTile(
          title: 'Logout',
          subtitle: 'Logout from app',
          icon: Icons.logout,
          press: () {
            _controller.logoutUser(context);
          },
        )
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback press;
  const SettingsTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: Icon(
        icon,
        color: kPrimaryColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        subtitle,
        style:
            Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: kPrimaryColor,
      ),
    );
  }
}
