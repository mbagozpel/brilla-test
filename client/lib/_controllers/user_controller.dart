import 'package:client/FirebaseDB/firebase_auth.dart';
import 'package:client/FirebaseDB/firebase_database.dart';
import 'package:client/FirebaseDB/firebase_storage.dart';
import 'package:client/_models/app_user.dart';
import 'package:client/_services/account_services.dart';
import 'package:client/_services/response.dart';
import 'package:client/_utilities/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserController extends GetxController {
  final FirebaseAuthSource _authSource = FirebaseAuthSource();

  final FirebaseDatabaseSource _dbSource = FirebaseDatabaseSource();

  final FirebaseStorageSource _dbStorage = FirebaseStorageSource();

  User? firebaseUser = FirebaseAuth.instance.currentUser;
  AppUser? user;

  bool isLoading = false;

  void updatePhoto(
      {required String photoPath, required BuildContext context}) async {
    isLoading = true;

    Response<dynamic> response =
        await _dbStorage.uploadUserPhoto(filePath: photoPath, userId: user!.id);

    isLoading = false;

    if (response is Success<String>) {
      user!.photoPath = response.value;
    }
  }
}
