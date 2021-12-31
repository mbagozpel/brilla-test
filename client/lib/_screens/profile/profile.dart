import 'package:client/_controllers/account_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  // final AppUser? user;
  Profile({
    Key? key,
  }) : super(key: key);
  final AccountController _controller = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageCard(image: _controller.appUser.value.photoPath),
              SizedBox(
                height: _size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _controller.appUser.value.username,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _controller.appUser.value.phoneNumber,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(height: 1.5, color: Colors.grey),
                    ),
                    Row(
                      children: List.generate(
                          _controller.appUser.value.interests.length, (index) {
                        return Text(
                          '${_controller.appUser.value.interests[index]}, ',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(height: 1.5, color: Colors.grey),
                        );
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String image;
  const ImageCard({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height * 0.6,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
