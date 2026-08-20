import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/controllers/auth_controller.dart';
import 'package:weather_app/features/auth/controllers/cubit/auth_state.dart';
import 'package:weather_app/features/auth/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthController authController;
  AuthCubit(this.authController) : super(AuthInitial());

  Future<void> registerCubit({
    required UserModel user,
    required String password,
  }) async {
    emit(AuthLoading());
    final String? error = await authController.signUpEmailPassword(
      user: user,
      password: password,
    );
    if (error == null) {
      emit(AuthSuccess());
    } else {
      emit(AuthError(errorMessage: error));
    }
  }

  Future<void> signinCubit({
    required String email,
    required String password,
    required bool isRememberMe,
  }) async {
    emit(AuthLoading());
    final String? error = await authController.loginEmailPassword(
      rememberMe: isRememberMe,
      email: email,
      password: password,
    );
    if (error == null) {
      emit(AuthSuccess());
    } else {
      emit(AuthError(errorMessage: error));
    }
  }

  Future<void> logoutCubit() async {
    emit(AuthLoading());
    final String? error = await authController.logout();
    if (error == null) {
      emit(AuthSuccess());
    } else {
      emit(AuthError(errorMessage: error));
    }
  }

  Future<void> resetCubit({required String email}) async {
    emit(AuthLoading());
    final String? error = await authController.resetPassword(email: email);
    if (error == null) {
      emit(AuthSuccess());
    } else {
      emit(AuthError(errorMessage: error));
    }
  }
}
