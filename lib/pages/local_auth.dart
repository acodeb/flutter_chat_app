import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import "dart:async";

class Authenticate {
  static bool authenticated = false;
  static Future<bool> authenticate() async {
    final localAuth = new LocalAuthentication();
    try {
      authenticated = await localAuth.authenticateWithBiometrics(
        localizedReason: "TouchID",
        useErrorDialogs: true,
        stickyAuth: false
      );
    } on PlatformException catch(e) {
      print('Error -> $e');
    }
    return authenticated;
  }
}
