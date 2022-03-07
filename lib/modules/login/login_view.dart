import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unsplashed_client/modules/home/home_view.dart';
import 'package:unsplashed_client/theme/app_colors.dart';
import 'package:unsplashed_client/theme/app_theme.dart';
import 'package:unsplashed_client/utils/helpers.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({Key? key}) : super(key: key);

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  SharedPreferences? prefs;
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _showEmailValidationMessage = false;
  bool _showPasswordValidationMessage = false;
  bool _isLoading = false;
  bool _useLocalRepo = false;

  @override
  void initState() {
    super.initState();
    _makeAsyncCalls();
  }

  void _makeAsyncCalls() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: AppColors.bgGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 50, 0, 0),
                  child: Lottie.network(
                      'https://assets6.lottiefiles.com/packages/lf20_GZxjzF.json',
                      animate: true,
                      repeat: false,
                      width: 200,
                      height: 200),
                ),
              ),
              Text(
                "UNSPLASHED",
                style: AppTheme.heroTextStyle,
                textAlign: TextAlign.center,
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 800,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 40, 12, 0),
                  child: TextField(
                    cursorColor: AppColors.lightPurple,
                    controller: loginController,
                    onChanged: onChangeUsername,
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
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Helpers.isFirebaseSupported()
                      ? TextField(
                          cursorColor: AppColors.lightPurple,
                          obscureText: true,
                          controller: passwordController,
                          onChanged: onChangePassword,
                          decoration: InputDecoration(
                            errorText: _showPasswordValidationMessage
                                ? "Password must be at least 6 letters long"
                                : null,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: const OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            (prefs?.setString('email', (loginController.text)))
                                ?.then((value) {
                              print(
                                  "prefs?.geString('email') -> ${prefs?.getString('email')}");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            });
                          },
                          child: Text(
                            "CONTINUE",
                            style: AppTheme.heroTextStyle,
                          )),
                ),
              ),
              Helpers.isFirebaseSupported()
                  ? Center(
                      child: !_isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 8, 4, 0),
                                    child: ElevatedButton(
                                      child: Text("Login"),
                                      onPressed: () async {
                                        validate();
                                        if (_showEmailValidationMessage ||
                                            _showPasswordValidationMessage)
                                          return;
                                        UserCredential? userCredential;
                                        userCredential = await loginUser(
                                            userCredential, context);
                                        if (userCredential?.user?.uid != null) {
                                          print(
                                              "SUCCESS FIREBASE AUTH | prefs -> $prefs");
                                          await prefs?.setString('uid',
                                              (userCredential?.user?.uid)!);
                                          (prefs?.setString('email',
                                                  (loginController.text)))
                                              ?.then((value) {
                                            print("SUCCESS -> $value");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage())).catchError(
                                                (_) => print("FAILED error"));
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          4, 8, 12, 0),
                                      child: ElevatedButton(
                                        child: Text("Register"),
                                        onPressed: () async {
                                          validate();
                                          if (_showEmailValidationMessage ||
                                              _showPasswordValidationMessage)
                                            return;
                                          UserCredential? userCredential;
                                          userCredential = await registerUser(
                                              userCredential, context);
                                          if (userCredential?.user?.uid !=
                                              null) {
                                            showAlertWithMessage(
                                                context,
                                                "Successfully registered ${loginController.text}",
                                                "Press OK to continue in the app");
                                          }
                                        },
                                      )),
                                ),
                              ],
                            )
                          : const Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: CircularProgressIndicator.adaptive(),
                            ),
                    )
                  : Container(),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                checkColor: AppColors.primary,
                activeColor: AppColors.lightRed,
                title: const Text(
                    'Check this to use local json instead Unsplash API'),
                value: _useLocalRepo,
                onChanged: (bool? value) async {
                  setState(() {
                    _useLocalRepo = value ?? false;
                    print("check change -> $value");
                  });
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('useLocalRepo', value ?? true);
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    constraints: BoxConstraints(
                        maxHeight: 24,
                        minWidth: MediaQuery.of(context).size.width),
                    color: AppColors.grayBG,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset('assets/ps.png'),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential?> loginUser(
      UserCredential? userCredential, BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showAlertWithMessage(
            context, "Something went wrong", "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showAlertWithMessage(
            context, "Something went wrong", "email or password is incorrect.");
      }
    }
    setState(() {
      _isLoading = false;
    });
    return userCredential;
  }

  Future<UserCredential?> registerUser(
      UserCredential? userCredential, BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: loginController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showAlertWithMessage(context, "Something went wrong",
            "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showAlertWithMessage(context, "Something went wrong",
            "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
    return userCredential;
  }

  void validate() {
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
  }

  void onChangePassword(text) {
    setState(
      () {
        _showPasswordValidationMessage = false;
      },
    );
  }

  void onChangeUsername(text) {
    setState(
      () {
        _showEmailValidationMessage = false;
      },
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
