import 'package:client/_controllers/account_controller.dart';
import 'package:client/_utilities/constants.dart';
import 'package:client/_widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordForm extends StatelessWidget {
  ChangePasswordForm({Key? key}) : super(key: key);
  static final _passwordKey = GlobalKey<FormState>();
  final AccountController _controller = Get.find<AccountController>();
  String currentPassword = '';
  String newPassword = '';

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Form(
      key: _passwordKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: _size.height * 0.06,
            ),
            Obx(
              () => TextFormField(
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
                    labelText: 'Current Password',
                    hintText: 'Enter you current-password'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) return kPassNullError;

                  return null;
                },
                onSaved: (value) {
                  currentPassword = value!.trim();
                },
              ),
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
                      labelText: 'New Password',
                      hintText: 'Enter you new-password'),
                  validator: (value) {
                    if (value!.isEmpty) return kPassNullError;

                    if (value.length < 8) return kShortPassError;

                    return null;
                  },
                  onSaved: (value) {
                    newPassword = value!.trim();
                  },
                )),
            SizedBox(
              height: _size.height * 0.04,
            ),
            SizedBox(height: _size.height * 0.06),
            Obx(() => _controller.isLoading.isTrue
                ? const CircularProgressIndicator(
                    color: kPrimaryColor,
                  )
                : DefaultButton(
                    text: 'Update',
                    press: () {
                      bool isValid = _passwordKey.currentState!.validate();

                      if (isValid) {
                        _passwordKey.currentState!.save();
                        _controller.changePassword(
                            currentPassword: currentPassword,
                            newPassword: newPassword,
                            context: context);
                        _passwordKey.currentState!.reset();
                      }
                    },
                  )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
