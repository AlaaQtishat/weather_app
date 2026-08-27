import 'package:equatable/equatable.dart';

abstract class RecentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecentsLoading extends RecentsState {}

class RecentsLoaded extends RecentsState {
  final List<Map<String, dynamic>> recents;

  RecentsLoaded({required this.recents});

  @override
  List<Object?> get props => [recents];
}

class RecentsError extends RecentsState {
  final String errorMessage;

  RecentsError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
