import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(),
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
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(),
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
                        UserCredential? userCredential;
                        try {
                          userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: loginController.text,
                                  password: passwordController.text);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                        if (userCredential?.user?.uid == null) {
                          print("failed login");
                        } else {
                          print(
                              "login success! -> ${userCredential?.user?.uid}");
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
                      onPressed: () {
                        print(
                            "register pressed ->  ${loginController.text} / ${passwordController.text}");
                      },
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
