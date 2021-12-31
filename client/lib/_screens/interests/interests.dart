import 'package:client/_controllers/account_controller.dart';
import 'package:client/_models/interest_model.dart';
import 'package:client/_utilities/constants.dart';
import 'package:client/_widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'interest_card.dart';

class InterestScreen extends StatelessWidget {
  static const routeName = '/interests';
  InterestScreen({Key? key}) : super(key: key);
  final AccountController _controller = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final controller = args['controller'];

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
          'Interests',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.grey),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your interests',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Select a few of your interests and let everyone know what you’re passionate about.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(height: 1.5, color: Colors.grey),
              ),
              SizedBox(
                height: _size.height * 0.04,
              ),
              Wrap(
                spacing: 25,
                runSpacing: 10,
                children: List.generate(
                  chipList.length,
                  (index) => InterestCard(interest: chipList[index]),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(() => _controller.isLoading.isTrue
                  ? const CircularProgressIndicator(
                      color: kPrimaryColor,
                    )
                  : DefaultButton(
                      text: 'Continue',
                      press: () {
                        _controller.registerUser(
                          user: controller.user,
                          context: context,
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
