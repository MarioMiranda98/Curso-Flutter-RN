import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LocalAuthPlugin {
  LocalAuthPlugin._();

  static final LocalAuthentication auth = LocalAuthentication();

  // static Future<void> availableBiometrics() async {
  //   final List<BiometricType> availableBiometrics = await auth
  //       .getAvailableBiometrics();
  // }

  static Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Por favor autenticate para continuar',
        options: AuthenticationOptions(),
      );

      return (
        didAuthenticate,
        didAuthenticate ? 'Hecho' : 'Cancelado por el usuario',
      );
    } on PlatformException catch (e) {
      debugPrint(e.toString());

      if (e.code == auth_error.notEnrolled) {
        return (false, 'No hay biométricos enrolados');
      }

      if (e.code == auth_error.lockedOut) {
        return (false, 'Muchos intentos fallidos');
      }

      if (e.code == auth_error.notAvailable) {
        return (false, 'No hay biométricos disponibles');
      }

      if (e.code == auth_error.passcodeNotSet) {
        return (false, 'No hay un pin configurado');
      }

      if (e.code == auth_error.permanentlyLockedOut) {
        return (false, 'Se requiere desbloquear el teléfono de nuevo');
      }

      return (false, e.toString());
    }
  }
}
