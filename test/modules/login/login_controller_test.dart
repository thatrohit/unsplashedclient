import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unsplashed_client/modules/login/login_controller.dart';

void main() {
  final LoginController loginController = LoginController();
  test("validateEmail() valid email regular experssion text", () {
    var validEmail = "abc@xyz.com";
    expect(loginController.validateEmail(validEmail), true);
  });

  test("validateEmail() invalid email regular experssion text", () {
    var invalidEmail = "abc@xyzcom";
    expect(loginController.validateEmail(invalidEmail), false);
  });

  test("loginUser() verify firebase login", () async {
    var email = "abc@xyz.com";
    var password = "abcabc";
    var uid = "someuid";
    final user = MockUser(
      uid: uid,
      email: email,
      displayName: 'Bob',
    );
    final auth = MockFirebaseAuth(mockUser: user);
    final result = await auth.signInWithEmailAndPassword(
        email: user.email ?? "", password: password);
    final loggedInUser = result.user;
    expect(loggedInUser?.uid, uid);
  });
}
