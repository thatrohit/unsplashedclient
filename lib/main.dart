import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unsplashed_client/firebase_options.dart';
import 'package:unsplashed_client/modules/login/login_home.dart';
import 'package:unsplashed_client/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const UnsplashedClientApp());
}

class UnsplashedClientApp extends StatelessWidget {
  const UnsplashedClientApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Unsplashed"),
          ),
        ),
        body: const LoginHome(),
      ),
    );
  }
}
