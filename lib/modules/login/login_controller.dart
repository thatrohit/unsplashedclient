import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unsplashed_client/models/firebase_result.dart';

part 'login_controller.g.dart';

class LoginController = _LoginController with _$LoginController;

abstract class _LoginController with Store {
  @observable
  SharedPreferences? prefs;

  @observable
  bool isLoading = false;

  @observable
  bool showEmailError = false;

  @observable
  bool showPasswordError = false;

  @action
  Future<SharedPreferences?> getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  saveDataToSharedPreferences(Map<String, String> items) async {
    for (var element in items.entries) {
      await prefs?.setString(element.key, element.value);
    }
  }

  bool validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  @action
  Future<FirebaseAuthResult> loginUser(
    emailId,
    password,
  ) async {
    FirebaseAuthResult result = FirebaseAuthResult();
    UserCredential? userCredential;
    try {
      isLoading = true;
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailId, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result.errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        result.errorMessage = "email or password is incorrect.";
      } else {
        result.errorMessage = e.message;
      }
    }
    result.userCredential = userCredential;
    isLoading = false;
    return result;
  }

  @action
  Future<FirebaseAuthResult?> registerUser(emailId, password) async {
    FirebaseAuthResult result = FirebaseAuthResult();
    isLoading = true;
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailId, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        result.errorMessage = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        result.errorMessage = "The account already exists for that email.";
      } else {
        result.errorMessage = e.message;
      }
    }
    result.userCredential = userCredential;
    isLoading = false;
    return result;
  }

  @action
  void validate(String email, String password) {
    if (!validateEmail(email)) {
      showEmailError = true;
    } else {
      showEmailError = false;
    }
    if (password.length < 6) {
      showPasswordError = true;
    } else {
      showPasswordError = false;
    }
  }

  void onChangePassword() {
    showPasswordError = false;
  }

  void onChangeUsername() {
    showEmailError = false;
  }
}
