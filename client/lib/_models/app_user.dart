import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String id;

  String photoPath;
  String email;
  String password;
  List<dynamic> interests;
  String username;
  String phoneNumber;
  AppUser({
    required this.id,
    required this.photoPath,
    required this.email,
    required this.password,
    required this.interests,
    required this.username,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'id': id,
      'photoPath': photoPath,
      'email': email,
      'password': password,
      'interests': interests,
      'username': username
    };
  }

  factory AppUser.fromSnapshot(DocumentSnapshot snapshot) {
    return AppUser(
      phoneNumber: snapshot['phoneNumber'],
      username: snapshot['username'],
      id: snapshot['id'] ?? '',
      photoPath: snapshot['photoPath'] ?? '',
      email: snapshot['email'] ?? '',
      password: snapshot['password'] ?? '',
      interests: snapshot['interests'] ?? '',
    );
  }
}
