import 'package:equatable/equatable.dart';

sealed class LocationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {
  @override
  List<Object?> get props => [];
}

class LocationLoading extends LocationState {
  @override
  List<Object?> get props => [];
}

class LocationLoaded extends LocationState {
  final String cityName;
  LocationLoaded(this.cityName);
  @override
  List<Object?> get props => [cityName];
}

class LocationError extends LocationState {
  final String errorMessage;
  LocationError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
