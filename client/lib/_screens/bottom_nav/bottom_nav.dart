import 'package:client/_controllers/other_controllers.dart';
import 'package:client/_models/app_user.dart';
import 'package:client/_screens/Discover/discover.dart';
import 'package:client/_screens/buddies/buddies.dart';
import 'package:client/_screens/profile/profile.dart';
import 'package:client/_screens/settings/settings.dart';
import 'package:client/_utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);
  static const routeName = '/bottomNav';

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final OtherControllers _controller = OtherControllers();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _pages = [
      {
        'title': 'Profile',
        'widget': Profile(
            // user: user,
            )
      },
      {'title': 'Buddies', 'widget': const Buddies()},
      {'title': 'Discover', 'widget': const Discover()},
      {'title': 'Settings', 'widget': SettingsPrivacy()}
    ];

    return Obx(() => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              _pages[_controller.bottomIndex.value]['title'],
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.grey),
            ),
            centerTitle: true,
          ),
          body: _pages[_controller.bottomIndex.value]['widget'],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              _controller.setNavIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: _controller.bottomIndex.value,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.person),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.people),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.sports),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.settings),
              ),
            ],
          ),
        ));
  }
}
