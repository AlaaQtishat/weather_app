import 'package:equatable/equatable.dart';
import 'package:weather_app/features/user/models/user_model.dart';

abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoaded extends UserState {
  final UserModel user;

  UserLoaded({required this.user});
  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  final String errorMessage;

  UserError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
