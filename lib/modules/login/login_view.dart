import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:unsplashed_client/models/firebase_result.dart';
import 'package:unsplashed_client/modules/home/home_view.dart';
import 'package:unsplashed_client/modules/login/login_controller.dart';
import 'package:unsplashed_client/theme/app_colors.dart';
import 'package:unsplashed_client/theme/app_theme.dart';
import 'package:unsplashed_client/utils/helpers.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({Key? key}) : super(key: key);

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  LoginController loginController = LoginController();
  TextEditingController loginTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool _useLocalRepo = false;

  @override
  void initState() {
    super.initState();
    _makeAsyncCalls();
  }

  void _makeAsyncCalls() async {
    await loginController.getSharedPreferences();
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
                child: Semantics(
                  label: 'Hero Image',
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 50, 0, 0),
                      child: SizedBox(
                        child: Image.asset('assets/logo.png'),
                        height: 200,
                        width: 200,
                      )
                      // Lottie.network(
                      //     'https://assets6.lottiefiles.com/packages/lf20_GZxjzF.json',
                      //     animate: true,
                      //     repeat: false,
                      //     width: 200,
                      //     height: 200),
                      ),
                ),
              ),
              Text(
                "UNSPLASHED",
                semanticsLabel: 'unsplashed',
                style: AppTheme.heroTextStyle,
                textAlign: TextAlign.center,
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 800,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 40, 12, 0),
                  child: Observer(
                    builder: (_) => TextField(
                      cursorColor: AppColors.lightPurple,
                      controller: loginTextController,
                      onChanged: (text) => loginController.onChangeUsername(),
                      decoration: InputDecoration(
                        errorText: loginController.showEmailError
                            ? "Invalid email address"
                            : null,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: const OutlineInputBorder(),
                        labelText: 'Username',
                      ),
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
                      ? Observer(
                          builder: (_) => TextField(
                            cursorColor: AppColors.lightPurple,
                            obscureText: true,
                            controller: passwordTextController,
                            onChanged: (text) =>
                                loginController.onChangePassword(),
                            decoration: InputDecoration(
                              errorText: loginController.showPasswordError
                                  ? "Password must be at least 6 letters long"
                                  : null,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            loginController.saveDataToSharedPreferences({
                              'email': loginTextController.text,
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          child: Text(
                            "CONTINUE",
                            style: AppTheme.heroTextStyle,
                          )),
                ),
              ),
              Helpers.isFirebaseSupported()
                  ? Observer(
                      builder: (_) => Center(
                        child: !(loginController.isLoading)
                            ? Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 800,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 8, 4, 0),
                                        child: ElevatedButton(
                                          child: const Text("Login"),
                                          onPressed: () async {
                                            loginController.validate(
                                                loginTextController.text,
                                                passwordTextController.text);
                                            if (loginController
                                                    .showEmailError ||
                                                loginController
                                                    .showPasswordError) {
                                              return;
                                            }

                                            FirebaseAuthResult result =
                                                await loginController.loginUser(
                                                    loginTextController.text,
                                                    passwordTextController
                                                        .text);
                                            if (result.errorMessage != null) {
                                              showAlertWithMessage(
                                                  context, result.errorMessage);
                                              return;
                                            } else {
                                              await loginController
                                                  .saveDataToSharedPreferences(
                                                {
                                                  'uid': result.userCredential
                                                          ?.user?.uid ??
                                                      "",
                                                  'email':
                                                      loginTextController.text
                                                },
                                              );
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage()));
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
                                            child: const Text("Register"),
                                            onPressed: () async {
                                              loginController.validate(
                                                  loginTextController.text,
                                                  passwordTextController.text);
                                              if (loginController
                                                      .showEmailError ||
                                                  loginController
                                                      .showPasswordError) {
                                                return;
                                              }
                                              FirebaseAuthResult? result =
                                                  await loginController
                                                      .registerUser(
                                                          loginTextController
                                                              .text,
                                                          passwordTextController
                                                              .text);
                                              if (result?.errorMessage !=
                                                  null) {
                                                showAlertWithMessage(
                                                  context,
                                                  result?.errorMessage,
                                                );
                                              } else {
                                                showAlertWithMessage(
                                                  context,
                                                  "Press login to continue in the app",
                                                  title:
                                                      "Successfully registered ${loginTextController.text}",
                                                );
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: CircularProgressIndicator.adaptive(),
                              ),
                      ),
                    )
                  : Container(),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 800,
                ),
                child: CheckboxListTile(
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
                    await loginController.saveDataToSharedPreferences(
                        {'useLocalRepo': (value ?? false).toString()});
                  },
                ),
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

  void showAlertWithMessage(BuildContext context, String? body,
      {String? title}) {
    AlertDialog alert = AlertDialog(
      title: Text(title ?? "Something went wrong"),
      content: Text(body ?? ""),
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
