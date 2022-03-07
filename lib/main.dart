import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unsplashed_client/firebase_options.dart';
import 'package:unsplashed_client/modules/login/login_view.dart';
import 'package:unsplashed_client/modules/search/search_view.dart';
import 'package:unsplashed_client/theme/app_theme.dart';
import 'package:unsplashed_client/utils/helpers.dart';
import 'package:unsplashed_client/utils/scroll_behavior.dart';

void main() async {
  if (Helpers.isFirebaseSupported()) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  runApp(const UnsplashedClientApp());
}

class UnsplashedClientApp extends StatelessWidget {
  const UnsplashedClientApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: UnsplashedCustomScrollBehavior(),
        theme: AppTheme.appTheme,
        home: const Scaffold(
          body: LoginHome(),
        ));
  }
}
