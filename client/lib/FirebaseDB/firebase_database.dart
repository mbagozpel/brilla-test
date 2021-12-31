import 'package:client/_models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabaseSource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void addUser(AppUser user) {
    _db.collection('users').doc(user.id).set(user.toMap());
  }

  void updateUser(AppUser user) async {
    _db.collection('users').doc(user.id).update(user.toMap());
  }

  Future<DocumentSnapshot> getUser(String userId) {
    return _db.collection('users').doc(userId).get();
  }
}
