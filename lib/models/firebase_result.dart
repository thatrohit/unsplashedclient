import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthResult {
  String? errorMessage;
  UserCredential? userCredential;
  FirebaseAuthResult({this.errorMessage, this.userCredential});
}
