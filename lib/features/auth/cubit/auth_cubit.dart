import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/cubit/auth_state.dart';
import 'package:weather_app/features/auth/services/auth_service.dart';
import 'package:weather_app/features/auth/services/remember_me_prefs.dart';
import 'package:weather_app/features/user/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;
  final RememberMePrefs prefs;

  AuthCubit(this.authService, this.prefs) : super(AuthInitial());

  Future<void> signinCubit({
    required String email,
    required String password,
    required bool isRememberMe,
  }) async {
    emit(AuthLoading());
    try {
      await authService.signIn(email: email, password: password);

      if (isRememberMe) {
        await prefs.saveEmail(email);
        await prefs.savePassword(password);
      } else {
        await prefs.clearCredentials();
      }

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e, st) {
      print("FirebaseAuthException in login: ${e.message} , $st");
      emit(AuthError(errorMessage: e.message ?? "Authentication failed"));
    } catch (e, st) {
      print("Unexpected error in login: ${e.toString()} , $st");
      emit(
        AuthError(
          errorMessage: "Something went wrong, please try again later.",
        ),
      );
    }
  }

  Future<void> registerCubit({
    required UserModel user,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await authService.createAccount(user: user, password: password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e, st) {
      print("FirebaseAuthException in signup: ${e.message} , $st");
      emit(AuthError(errorMessage: e.message ?? "Registration failed"));
    } catch (e, st) {
      print("Unexpected error in signup: ${e.toString()} , $st");
      emit(
        AuthError(
          errorMessage: "Something went wrong, please try again later.",
        ),
      );
    }
  }

  Future<void> resetCubit({required String email}) async {
    emit(AuthLoading());
    try {
      await authService.resetPassword(email: email);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e, st) {
      print("FirebaseAuthException in resetPassword: ${e.message} , $st");
      emit(AuthError(errorMessage: e.message ?? "Reset failed"));
    } catch (e, st) {
      print("Unexpected error in resetPassword: ${e.toString()} , $st");
      emit(
        AuthError(
          errorMessage: "Something went wrong, please try again later.",
        ),
      );
    }
  }

  Future<void> logoutCubit() async {
    emit(AuthLoading());
    try {
      await authService.logout();
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e, st) {
      print("FirebaseAuthException in logout: ${e.message} , $st");
      emit(AuthError(errorMessage: e.message ?? "Logout failed"));
    } catch (e, st) {
      print("Unexpected error in logout: ${e.toString()} , $st");
      emit(
        AuthError(
          errorMessage: "Something went wrong, please try again later.",
        ),
      );
    }
  }
}
