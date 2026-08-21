import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
