import 'package:client/FirebaseDB/firebase_auth.dart';
import 'package:client/FirebaseDB/firebase_database.dart';
import 'package:client/FirebaseDB/firebase_storage.dart';
import 'package:client/_models/app_user.dart';
import 'package:client/_models/user_reg.dart';
import 'package:client/_services/response.dart';
import 'package:client/_utilities/shared_pref.dart';
import 'package:client/_utilities/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountServices {
  final FirebaseAuthSource _authSource = FirebaseAuthSource();

  final FirebaseDatabaseSource _dbSource = FirebaseDatabaseSource();

  final FirebaseStorageSource _dbStorage = FirebaseStorageSource();

  final firebaseUser = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static AppUser? appUser;

  Future<AppUser> get user => getUser();

  Future<Response> loginUser(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    Response<dynamic> response =
        await _authSource.signIn(email: email, password: password);

    if (response is Success<UserCredential>) {
      String id = response.value.user!.uid;

      await SharedPrefUtils.setUserID(Id: id);
    } else if (response is Error) {
      showSnackBar(context, text: response.message);
    }
    return response;
  }

  Future<Response> registerUser(
      UserRegistration userReg, BuildContext context) async {
    Response<dynamic> response = await _authSource.registerUser(
        email: userReg.email, password: userReg.password);

    if (response is Success<UserCredential>) {
      try {
        await firebaseUser!.sendEmailVerification();
      } catch (e) {
        showSnackBar(context, text: e.toString());
      }

      String id = (response).value.user!.uid;

      response = await _dbStorage.uploadUserPhoto(
          filePath: userReg.photoPath, userId: id);

      if (response is Success<String>) {
        String photoUrl = response.value;
        AppUser user = AppUser(
            phoneNumber: 'Nil',
            email: userReg.email,
            password: userReg.password,
            id: id,
            interests: userReg.interests,
            username: userReg.username,
            photoPath: photoUrl);

        _dbSource.addUser(user);
        await SharedPrefUtils.setUserID(Id: id);

        appUser = user;

        return Response.success(user);
      }
    }

    if (response is Error) showSnackBar(context, text: response.message);
    return response;
  }

  Future<AppUser> getUser() async {
    // if (appUser != null) return appUser!;

    String? id = await SharedPrefUtils.getUserId();

    AppUser user = AppUser.fromSnapshot(
      await _dbSource.getUser(id!),
    );
    return user;
  }

  void changePassword(
      String currentPassword, String newPassword, BuildContext context) async {
    try {
      if (firebaseUser != null) {
        final cred = EmailAuthProvider.credential(
            email: firebaseUser!.email!, password: currentPassword);

        await firebaseUser!.reauthenticateWithCredential(cred);
        await firebaseUser!.updatePassword(newPassword).then((value) {
          showSnackBar(context, text: 'Password updated successfully');
        });
      } else {
        showSnackBar(context, text: 'Please do re-login');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        showSnackBar(context, text: 'Incorrect password');
      }
      if (e.code == 'weak-password') {
        showSnackBar(context, text: 'You\'ve entered a weak password');
      }
      if (e.code == 'requires-recent-login') {
        showSnackBar(context, text: 'Please re-login');
      }
    } catch (e) {
      showSnackBar(context, text: e.toString());
    }
  }

  void updateEmail(
      {required String email,
      required String password,
      required String newEmail,
      required BuildContext context}) async {
    try {
      if (firebaseUser != null) {
        final cred =
            EmailAuthProvider.credential(email: email, password: password);

        await firebaseUser!.reauthenticateWithCredential(cred);

        await firebaseUser!.updateEmail(newEmail).then((value) =>
            {showSnackBar(context, text: "Profile Updated Succefully")});
      } else {
        showSnackBar(context, text: 'Please do re-login');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'no-current-user') {
        showSnackBar(context, text: 'Please re-login');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, text: 'You\'ve entered a wrong password');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, text: 'Email already in use');
      } else if (e.code == 'requires-recent-login') {
        showSnackBar(context, text: 'Please re-login');
      } else {
        showSnackBar(context, text: e.toString());
      }
    }
  }

  void updateProfile(AppUser user, newUsername, email) {
    user.username = newUsername;
    user.email = email;
    _dbSource.updateUser(user);
  }

  void updatePhone(AppUser user, phoneNumber) {
    user.phoneNumber = phoneNumber;
    _dbSource.updateUser(user);
  }

  void resetPassword(String email, BuildContext context) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      showSnackBar(context, text: 'A password-reset code has been sent to you');
    }).catchError((e) {
      showSnackBar(context, text: e.toString());
    });
  }

  void confirmCode(
      {required String code,
      required String newPassword,
      required BuildContext context}) async {
    _auth
        .confirmPasswordReset(code: code, newPassword: newPassword)
        .then((value) {
      showSnackBar(context, text: 'Password successfully changed');
    }).catchError((e) {
      showSnackBar(context, text: e.toString());
    });
    ;
  }

  void logoutUser() async {
    await _authSource.logoutUser();
  }
}
