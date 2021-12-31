import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:client/_controllers/other_controllers.dart';
import 'package:client/_models/app_user.dart';
import 'package:client/_models/user_reg.dart';
import 'package:client/_screens/Onboarding/onboarding.dart';
import 'package:client/_screens/bottom_nav/bottom_nav.dart';
import 'package:client/_screens/phone_verification/phone_verification.dart';
import 'package:client/_services/account_services.dart';
import 'package:client/_services/response.dart';
import 'package:client/_utilities/shared_pref.dart';

class AccountController extends GetxController {
  var isLoading = false.obs;
  var isVisible = true.obs;
  final AccountServices accountServices = AccountServices();
  UserRegistration user = UserRegistration();
  String firstPassword = '';
  var image = File('').obs;
  final ImagePicker _imagePicker = ImagePicker();

  final FirebaseAuth auth = FirebaseAuth.instance;
  String? verificationCode;
  var otp = TextEditingController().obs;
  var phoneNumber = ''.obs;

  var appUser = AppUser(
          id: '',
          photoPath: '',
          email: '',
          password: '',
          interests: [],
          username: '',
          phoneNumber: '')
      .obs;

//Function to select image
  void selectImage(UserRegistration user) async {
    final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      File _pickedImage = File(pickedFile.path);
      await SharedPrefUtils.setUserPic(path: pickedFile.path);
      user.photoPath = pickedFile.path;
      image.value = _pickedImage;
    }
  }

//function to login user
  void loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);
      var response = await accountServices.loginUser(context,
          email: email, password: password);

      if (response is Success) {
        appUser.value = await accountServices.getUser();
        // if login is successful, navigate to homepage
        Navigator.restorablePushNamed(
          context,
          BottomNav.routeName,
        );
      }
    } finally {
      isLoading(false);
    }
  }

// function to register a user
  void registerUser({
    required UserRegistration user,
    required BuildContext context,
  }) async {
    user.interests = OtherControllers.userInterests;
    try {
      isLoading(true);
      var response = await accountServices.registerUser(user, context);

      if (response is Success) {
        Navigator.restorablePushNamed(context, VerificationScreen.routeName);
      }
    } finally {
      isLoading(false);
    }
  }

  void changePassword(
      {required String currentPassword,
      required String newPassword,
      required BuildContext context}) {
    try {
      isLoading(true);
      accountServices.changePassword(currentPassword, newPassword, context);
    } finally {
      isLoading(false);
    }
  }

  void sendPasswordReset(
      {required String email, required BuildContext context}) {
    accountServices.resetPassword(email, context);
  }

  void confirmCode(
      {required String code,
      required String newPassword,
      required BuildContext context}) {
    accountServices.confirmCode(
        code: code, newPassword: newPassword, context: context);
  }

  void updateProfile(
      {required String email,
      required String newEmail,
      required String password,
      required BuildContext context,
      required AppUser user,
      required String newUsername}) async {
    try {
      isLoading(true);
      if (newEmail.isNotEmpty) {
        accountServices.updateEmail(
            newEmail: newEmail,
            email: email,
            password: password,
            context: context);
      }

      accountServices.updateProfile(user, newUsername, newEmail);

      appUser.value = await accountServices.getUser();
    } finally {
      isLoading(false);
    }
  }

  void saveForm({
    required GlobalKey<FormState> formKey,
  }) {
    bool isValid = formKey.currentState!.validate();

    if (isValid) {
      formKey.currentState!.save();
    } else {
      return;
    }
  }

  void updatePhone(AppUser user, String phoneNumber) {
    accountServices.updatePhone(user, phoneNumber);
  }

  Future<void> logoutUser(BuildContext context) async {
    await SharedPrefUtils.removeUserId();
    accountServices.logoutUser();
    Navigator.restorablePushNamed(context, OnboardingScreen.routeName);
  }

  Future<void> phoneSignIn({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
  }) async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeAutoRetrievalTimeout);
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    verificationCode = verificationId;
  }

  _onCodeAutoRetrievalTimeout(String verificationId) {
    verificationCode = verificationId;
  }
}
