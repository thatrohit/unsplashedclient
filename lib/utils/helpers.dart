import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum ResponseRepository {
  web,
  local,
}

class Helpers {
  static bool isFirebaseSupported() =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      (kIsWeb && defaultTargetPlatform == TargetPlatform.windows);
}
