import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/features/auth/services/auth_service.dart';

class AuthController {
  AuthService authService = AuthService();
  // SharedPrefsService sharedPrefsService = SharedPrefsService();

  Future<String?> loginEmailPassword({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      await authService.signIn(email: email, password: password);
      if (rememberMe) {
        // await sharedPrefsService.saveEmail(email);
        // await sharedPrefsService.savePassword(password);
      } else {
        // await sharedPrefsService.clearCredentials();
      }
      return null;
    } on FirebaseAuthException catch (e, st) {
      print("FirebaseAuthException in login: ${e.message} , $st");
      return e.message;
    } catch (e, st) {
      print("Unexpected error in login: ${e.toString()} , $st");
      return "something went wrong, please try again later.";
    }
  }
  //هاد اظن هون انه لازم يتعدل لليستقبل ال model
  //
  // Future<String?> signUpEmailPassword({
  //   required String email,
  //   required String password,
  //   required String name,
  // }) async {
  //   try {
  //     await authService.createAccount(user: UserModel(), password: password);
  //     await sharedPrefsService.saveEmail(email);
  //     return null;
  //   } on FirebaseAuthException catch (e, st) {
  //     print("FirebaseAuthException in signup: ${e.message} , $st");
  //     return e.message;
  //   } catch (e, st) {
  //     print("Unexpected error in signup: ${e.toString()} , $st");
  //     return "something went wrong, please try again later.";
  //   }
  // }

  Future<String?> resetPassword({required String email}) async {
    try {
      // await authService.resetPassword(email);
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
