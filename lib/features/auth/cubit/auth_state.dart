import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  final String loadingSource;

  AuthLoading({required this.loadingSource});

  @override
  List<Object?> get props => [loadingSource];
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
