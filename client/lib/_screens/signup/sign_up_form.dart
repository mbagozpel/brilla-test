import 'dart:io';

import 'package:client/_controllers/account_controller.dart';
import 'package:client/_screens/interests/interests.dart';
import 'package:client/_screens/signup/already_have.dart';
import 'package:client/_utilities/constants.dart';
import 'package:client/_utilities/shared_pref.dart';
import 'package:client/_utilities/utilities.dart';
import 'package:client/_widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);
  final AccountController _controller = AccountController();
  static final _formKey = GlobalKey<FormState>();
  Future<String>? firstPassword;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              SelectImage(controller: _controller),
              SizedBox(
                height: _size.height * 0.04,
              ),
              _email(),
              SizedBox(
                height: _size.height * 0.04,
              ),
              _username(),
              SizedBox(
                height: _size.height * 0.04,
              ),
              _password(),
              SizedBox(
                height: _size.height * 0.04,
              ),
              // _password2(),
              // SizedBox(height: _size.height * 0.06),
              Obx(() => _controller.isLoading.isTrue
                  ? const CircularProgressIndicator()
                  : DefaultButton(
                      press: () async {
                        var photoPath =
                            await SharedPrefUtils.getUserPhotoPath();
                        if (photoPath != null) {
                          _controller.user.photoPath = photoPath;
                        }
                        if (_controller.user.photoPath.isEmpty) {
                          return showSnackBar(context,
                              text: "Please Select an image");
                        } else {
                          _controller.saveForm(
                            formKey: _formKey,
                          );
                          Navigator.pushNamed(
                            context,
                            InterestScreen.routeName,
                            arguments: {'controller': _controller},
                          );
                        }
                      },
                      text: 'Continue')),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const AlreadyHave()
      ],
    );
  }

  Widget _email() {
    return TextFormField(
        key: const ValueKey('email'),
        keyboardType: TextInputType.emailAddress,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: true,
        decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.email,
              color: kPrimaryColor,
            ),
            hintText: 'Enter your email',
            labelText: 'Email'),
        onSaved: (value) {
          _controller.user.email = value!.trim();
        },
        validator: (value) {
          if (value!.isEmpty) return kEmailNullError;

          if (!emailValidatorRegExp.hasMatch(value)) return kInvalidEmailError;

          return null;
        });
  }

  Widget _username() {
    return TextFormField(
        key: const ValueKey('username'),
        autocorrect: true,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.person,
              color: kPrimaryColor,
            ),
            hintText: 'Enter your username',
            labelText: 'Username'),
        onSaved: (value) {
          _controller.user.username = value!.trim();
        },
        validator: (value) {
          if (value!.isEmpty) return kEmailNullError;

          return null;
        });
  }

  Widget _password() {
    return Obx(() => TextFormField(
          key: const ValueKey('password'),
          obscureText: true,
          autocorrect: _controller.isVisible.value,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
          validator: (value) {
            if (value!.isEmpty) return kPassNullError;

            if (value.length < 8) return kShortPassError;

            return null;
          },
          onChanged: (value) {},
          onSaved: (value) {
            _controller.user.password = value!.trim();
          },
        ));
  }
}

class SelectImage extends StatelessWidget {
  final AccountController controller;
  const SelectImage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AccountController>(
        init: AccountController(),
        builder: (_controller) => GestureDetector(
              onTap: () {
                _controller.selectImage(controller.user);
              },
              child: CircleAvatar(
                radius: 50,
                backgroundColor: kBgColor,
                backgroundImage: _controller.image.value.path.isEmpty
                    ? Image.asset('assets/images/user.png').image
                    : Image.file(_controller.image.value).image,
              ),
            ));
  }
}
