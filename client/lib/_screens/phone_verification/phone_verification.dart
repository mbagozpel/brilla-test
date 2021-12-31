import 'package:client/_controllers/account_controller.dart';
import 'package:client/_screens/bottom_nav/bottom_nav.dart';
import 'package:client/_utilities/constants.dart';
import 'package:client/_utilities/shared_pref.dart';
import 'package:client/_utilities/utilities.dart';
import 'package:client/_widgets/default_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'input_phone.dart';

//This particular widget is a little bit messy
//Implementing phone authentication with firebase for some reasons,
//requires business logic to be on same page
class VerificationScreen extends StatelessWidget {
  VerificationScreen({Key? key}) : super(key: key);
  static const routeName = '/verificationScreen';

  final AccountController _controller = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Mobile',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Phone Verification',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.black),
                  ),
                  Text(
                    'Please enter your valid phone number. We will send you a 6-digit code to verify your account.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(height: 1.5, color: Colors.grey),
                  ),
                  SizedBox(
                    height: _size.height * 0.04,
                  ),
                  InputPhoneNumber(),
                  SizedBox(
                    height: _size.height * 0.04,
                  ),
                  Obx(
                    () => Column(
                      children: [
                        DefaultButton(
                          text: 'Send code',
                          press: () {
                            FocusScope.of(context).unfocus();
                            //this is the only way I could place this business logic in order for it to be functional
                            //this is for automatic verification on android phones
                            onVerificationCompleted(
                                PhoneAuthCredential authCredential) async {
                              User? user = _controller.auth.currentUser;
                              _controller.otp.value.text =
                                  authCredential.smsCode!;
                              print(authCredential.smsCode);
                              if (authCredential.smsCode != null) {
                                try {
                                  _controller.isLoading(true);
                                  var value = await user!
                                      .linkWithCredential(authCredential);
                                  if (value.user != null) {
                                    _controller.appUser.value =
                                        await _controller.accountServices
                                            .getUser();
                                    _controller.updatePhone(
                                        _controller.appUser.value,
                                        _controller.phoneNumber.value);
                                    Navigator.restorablePushNamed(
                                      context,
                                      BottomNav.routeName,
                                    );
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'provider-already-linked') {
                                    var response = await _controller.auth
                                        .signInWithCredential(authCredential);

                                    if (response.user != null) {
                                      _controller.appUser.value =
                                          await _controller.accountServices
                                              .getUser();
                                      _controller.updatePhone(
                                          _controller.appUser.value,
                                          _controller.phoneNumber.value);
                                      Navigator.restorablePushNamed(
                                        context,
                                        BottomNav.routeName,
                                      );
                                    }
                                  }
                                } finally {
                                  _controller.isLoading(false);
                                }
                              }
                            }

                            onVerificationFailed(
                                FirebaseAuthException exception) {
                              showSnackBar(context, text: exception.message!);
                            }

                            _controller.phoneSignIn(
                                phoneNumber: _controller.phoneNumber.value,
                                verificationCompleted: onVerificationCompleted,
                                verificationFailed: onVerificationFailed
                                //
                                );
                          },
                        ),
                        SizedBox(
                          height: _size.height * 0.1,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: _controller.otp.value,
                          decoration: const InputDecoration(
                              hintText: 'Enter verification code',
                              labelText: 'Code'),
                        ),
                        SizedBox(
                          height: _size.height * 0.04,
                        ),
                        _controller.isLoading.isTrue
                            ? const CircularProgressIndicator(
                                color: kPrimaryColor)
                            : DefaultButton(
                                text: 'Continue',
                                press: () async {
                                  FocusScope.of(context).unfocus();
                                  User? user = _controller.auth.currentUser;

                                  try {
                                    _controller.isLoading(true);
                                    // Link phone number to existing user account
                                    if (user != null) {
                                      var value = await user.linkWithCredential(
                                          PhoneAuthProvider.credential(
                                              verificationId:
                                                  _controller.verificationCode!,
                                              smsCode:
                                                  _controller.otp.value.text));
                                      if (value.user != null) {
                                        _controller.appUser.value =
                                            await _controller.accountServices
                                                .getUser();
                                        _controller.updatePhone(
                                            _controller.appUser.value,
                                            _controller.phoneNumber.value);
                                        Navigator.restorablePushNamed(
                                          context,
                                          BottomNav.routeName,
                                        );
                                      }
                                    } else {
                                      var response = await _controller.auth
                                          .signInWithCredential(
                                              PhoneAuthProvider.credential(
                                                  verificationId: _controller
                                                      .verificationCode!,
                                                  smsCode: _controller
                                                      .otp.value.text));

                                      if (response.user != null) {
                                        await SharedPrefUtils.setUserID(
                                            Id: response.user!.uid);
                                        _controller.appUser.value =
                                            await _controller.accountServices
                                                .getUser();
                                        _controller.updatePhone(
                                            _controller.appUser.value,
                                            _controller.phoneNumber.value);
                                        Navigator.restorablePushNamed(
                                          context,
                                          BottomNav.routeName,
                                        );
                                      }
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    showSnackBar(context, text: e.toString());
                                  } finally {
                                    _controller.isLoading(false);
                                  }
                                }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
