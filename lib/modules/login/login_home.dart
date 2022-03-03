import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unsplashed_client/theme/app_colors.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({Key? key}) : super(key: key);

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _showEmailValidationMessage = false;
  bool _showPasswordValidationMessage = false;

  bool validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: AppColors.bgGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Lottie.network(
                      'https://assets1.lottiefiles.com/packages/lf20_hymrcjeq.json'),
                ),
                height: 260,
                width: 260,
              ),
            ),
            const SizedBox(
              height: 100,
              child: Text(
                "UNSPLASHED",
                style: TextStyle(
                  fontSize: 22,
                  color: AppColors.white,
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: AppColors.lightPurple,
                  controller: loginController,
                  onChanged: (text) {
                    setState(
                      () {
                        _showEmailValidationMessage = false;
                      },
                    );
                  },
                  decoration: InputDecoration(
                    errorText: _showEmailValidationMessage
                        ? "Invalid email address"
                        : null,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: const OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: AppColors.lightPurple,
                  obscureText: true,
                  controller: passwordController,
                  onChanged: (text) {
                    setState(
                      () {
                        _showPasswordValidationMessage = false;
                      },
                    );
                  },
                  decoration: InputDecoration(
                    errorText: _showPasswordValidationMessage
                        ? "Password must be at least 6 letters long"
                        : null,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 200,
                    maxWidth: 800,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text("Login"),
                        ),
                        onPressed: () async {
                          setState(
                            () {
                              if (!validateEmail(loginController.text)) {
                                _showEmailValidationMessage = true;
                              } else {
                                _showEmailValidationMessage = false;
                              }
                              if (passwordController.text.length < 6) {
                                _showPasswordValidationMessage = true;
                              } else {
                                _showPasswordValidationMessage = false;
                              }
                            },
                          );
                          if (_showEmailValidationMessage ||
                              _showPasswordValidationMessage) return;
                          UserCredential? userCredential;
                          try {
                            userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: loginController.text,
                                    password: passwordController.text);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showAlertWithMessage(
                                  context,
                                  "Something went wrong",
                                  "No user found for that email.");
                            } else if (e.code == 'wrong-password') {
                              showAlertWithMessage(
                                  context,
                                  "Something went wrong",
                                  "email or password is incorrect.");
                            }
                          }
                          if (userCredential?.user?.uid != null) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString(
                                'uid', (userCredential?.user?.uid)!);
                          }
                        },
                      )),
                ),
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 200,
                    maxWidth: 800,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text("Register"),
                        ),
                        onPressed: () async {
                          setState(
                            () {
                              if (!validateEmail(loginController.text)) {
                                _showEmailValidationMessage = true;
                              } else {
                                _showEmailValidationMessage = false;
                              }
                              if (passwordController.text.length < 6) {
                                _showPasswordValidationMessage = true;
                              } else {
                                _showPasswordValidationMessage = false;
                              }
                            },
                          );
                          if (_showEmailValidationMessage ||
                              _showPasswordValidationMessage) return;
                          UserCredential? userCredential;
                          try {
                            userCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: loginController.text,
                                    password: passwordController.text);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showAlertWithMessage(
                                  context,
                                  "Something went wrong",
                                  "The password provided is too weak.");
                            } else if (e.code == 'email-already-in-use') {
                              showAlertWithMessage(
                                  context,
                                  "Something went wrong",
                                  "The account already exists for that email.");
                            }
                          } catch (e) {
                            print(e);
                          }
                          if (userCredential?.user?.uid != null) {
                            showAlertWithMessage(
                                context,
                                "Successfully registered ${loginController.text}",
                                "Press OK to continue in the app");
                          }
                        },
                      )),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: 24,
                      minWidth: MediaQuery.of(context).size.width),
                  color: AppColors.background,
                  child: const Center(
                    child: Text("Unsplash Client - v1.0.0"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showAlertWithMessage(BuildContext context, String title, String body) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
