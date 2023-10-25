import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static Future<bool> checkBiometricAvailableOnDevice() async {
    try {
      return await _auth.canCheckBiometrics && await _auth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  static Future<List<BiometricType>> checkExistBiometric() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      return List<BiometricType>.empty();
    }
  }

  static Future<bool> isVisibleFeature() async {
    return await checkBiometricAvailableOnDevice() &&
        (await checkExistBiometric()).isNotEmpty;
  }

  static Future<bool> authenticate() async {
    var canAuth = await checkBiometricAvailableOnDevice();
    var reason = 'Authentication to view your favorite';
    if (canAuth) {
      try {
        return await _auth.authenticate(
          localizedReason: reason,
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
            useErrorDialogs: true,
          ),
        );
      } catch (e) {
        return false;
      }
    } else {
      return canAuth;
    }
  }
}
