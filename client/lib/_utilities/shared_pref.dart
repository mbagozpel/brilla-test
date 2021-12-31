import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static const String userIdKey = 'USER_ID_KEY';
  static const String userPhotoPath = 'USER_PHOTO';

  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  static Future<void> setUserID({required String Id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, Id);
  }

  static Future<void> removeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userIdKey);
  }

  static Future<void> setUserPic({required String path}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userPhotoPath, path);
  }

  static Future<String?> getUserPhotoPath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPhotoPath);
  }

  static Future<void> removeUserPhotoPath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userPhotoPath);
  }
}
