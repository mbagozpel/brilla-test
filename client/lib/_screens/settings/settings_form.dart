import 'package:client/_controllers/account_controller.dart';
import 'package:client/_utilities/constants.dart';
import 'package:client/_widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsForm extends StatelessWidget {
  SettingsForm({Key? key}) : super(key: key);
  final AccountController _controller = Get.find<AccountController>();
  static final _settingsKey = GlobalKey<FormState>();
  // final TextEditingController email = TextEditingController();
  // final TextEditingController password = TextEditingController();
  // final TextEditingController username = TextEditingController();
  String email = '';
  String password = '';
  String username = '';
  String newEmail = '';

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Form(
      key: _settingsKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: _size.height * 0.06,
              ),
              TextFormField(
                initialValue: _controller.appUser.value.email,
                autocorrect: true,
                // controller: email,
                decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.email,
                      color: kPrimaryColor,
                    ),
                    labelText: 'Email'),
                onSaved: (value) {
                  email = value!.trim();
                },
              ),
              SizedBox(
                height: _size.height * 0.04,
              ),
              TextFormField(
                autocorrect: true,
                // controller: username,
                decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.email,
                      color: kPrimaryColor,
                    ),
                    labelText: 'New Email',
                    hintText: 'Enter your new email'),
                onSaved: (value) {
                  newEmail = value!.trim();
                },
              ),
              SizedBox(
                height: _size.height * 0.04,
              ),
              TextFormField(
                initialValue: _controller.appUser.value.username,
                autocorrect: true,
                // controller: username,
                decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    labelText: 'Username'),
                onSaved: (value) {
                  username = value!.trim();
                },
              ),
              SizedBox(
                height: _size.height * 0.04,
              ),
              Obx(() => TextFormField(
                    autocorrect: true,
                    obscureText: _controller.isVisible.value,
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
                        labelText: 'Password'),
                    // controller: password,
                    onSaved: (value) {
                      password = value!.trim();
                    },
                  )),
              SizedBox(
                height: _size.height * 0.04,
              ),
              SizedBox(height: _size.height * 0.06),
              _controller.isLoading.isTrue
                  ? const CircularProgressIndicator(
                      color: kPrimaryColor,
                    )
                  : DefaultButton(
                      text: 'Update',
                      press: () {
                        bool isValid = _settingsKey.currentState!.validate();

                        if (isValid) {
                          _settingsKey.currentState!.save();
                          _controller.updateProfile(
                              newEmail: newEmail,
                              email: email,
                              password: password,
                              context: context,
                              user: _controller.appUser.value,
                              newUsername: username);
                        } else {
                          return;
                        }
                      },
                    ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
