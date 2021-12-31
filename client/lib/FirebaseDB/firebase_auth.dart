import 'package:client/_services/response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Response<UserCredential>> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return Response.success(userCredential);
    } catch (e) {
      return Response.error(
          (e as FirebaseAuthException).message ?? e.toString());
    }
  }

  Future<Response<UserCredential>> registerUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return Response.success(userCredential);
    } catch (e) {
      return Response.error(
          (e as FirebaseAuthException).message ?? e.toString());
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}
