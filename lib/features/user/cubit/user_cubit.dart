import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/user/models/user_model.dart';
import 'package:weather_app/features/user/services/user_service.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserService userService;

  UserCubit(this.userService) : super(UserInitial());

  Future<void> fetchUserData(String uid) async {
    emit(UserLoading());

    try {
      final UserModel? user = await userService.getUserData(uid);

      if (user != null) {
        emit(UserLoaded(user: user));
      } else {
        emit(UserError(errorMessage: "User data not found."));
      }
    } catch (e) {
      print("Error fetching user data: $e");
      emit(
        UserError(errorMessage: "Something went wrong while loading profile."),
      );
    }
  }

  void clearUserData() {
    emit(UserInitial());
  }
}
