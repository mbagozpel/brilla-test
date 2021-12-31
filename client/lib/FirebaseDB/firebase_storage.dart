import 'dart:io';

import 'package:client/_services/response.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageSource {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Response<String>> uploadUserPhoto(
      {required String filePath, required String userId}) async {
    String userPhotoPath = 'user_photos/$userId/profile_photo';

    try {
      //store file
      await _storage.ref(userPhotoPath).putFile(File(filePath));

      // get stored file url
      String downloadUrl = await _storage.ref(userPhotoPath).getDownloadURL();

      return Response.success(downloadUrl);
    } catch (e) {
      return Response.error((e as FirebaseException).message ?? e.toString());
    }
  }
}
