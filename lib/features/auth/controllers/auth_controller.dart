import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/features/auth/models/user_model.dart';
import 'package:weather_app/features/auth/services/auth_service.dart';
import 'package:weather_app/features/auth/services/remember_me_prefs.dart';

class AuthController {
  AuthService authService = AuthService();
  RememberMePrefs prefs = RememberMePrefs();
  Future<String?> loginEmailPassword({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      await authService.signIn(email: email, password: password);
      if (rememberMe) {
        await prefs.saveEmail(email);
        await prefs.savePassword(password);
      } else {
        await prefs.clearCredentials();
      }
      return null;
    } on FirebaseAuthException catch (e, st) {
      print("FirebaseAuthException in log in: ${e.message} , $st");
      return e.message;
    } catch (e, st) {
      print("Unexpected error in log in: ${e.toString()} , $st");
      return "something went wrong, please try again later.";
    }
  }

  Future<String?> signUpEmailPassword({
    required UserModel user,
    required String password,
  }) async {
    try {
      await authService.createAccount(user: user, password: password);
      return null;
    } on FirebaseAuthException catch (e, st) {
      print("FirebaseAuthException in signup: ${e.message} , $st");
      return e.message;
    } catch (e, st) {
      print("Unexpected error in signup: ${e.toString()} , $st");
      return "something went wrong, please try again later.";
    }
  }

  Future<String?> resetPassword({required String email}) async {
    try {
      await authService.resetPassword(email: email);
      return null;
    } on FirebaseAuthException catch (e, st) {
      print("FirebaseAuthException in resetPassword: ${e.message} , $st");
      return e.message;
    } catch (e, st) {
      print("Unexpected error in resetPassword: ${e.toString()} , $st");
      return "something went wrong, please try again later.";
    }
  }

  // Future<String?> facebookLogin() async {
  //   try {
  //     await authService.facebookLogin();
  //     return null;
  //   } catch (e, st) {
  //     print("Unexpected error in facebookLogin: ${e.toString()} , $st");
  //     return "something went wrong, please try again later.";
  //   }
  // }
  //
  // Future<String?> googleLogin() async {
  //   try {
  //     await authService.googleLogin();
  //     return null;
  //   } catch (e, st) {
  //     print("Unexpected error in googleLogin: ${e.toString()} , $st");
  //     return "something went wrong, please try again later.";
  //   }
  // }

  Future<String?> logout() async {
    try {
      await authService.logout();
      return null;
    } on FirebaseAuthException catch (e, st) {
      print("FirebaseAuthException in logout: ${e.message} , $st");
      return e.message;
    } catch (e, st) {
      print("Unexpected error in logout: ${e.toString()} , $st");
      return "something went wrong, please try again later.";
    }
  }
}
