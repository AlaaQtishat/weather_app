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
  final double lat;
  final double lon;

  LocationLoaded({
    required this.cityName,
    required this.lat,
    required this.lon,
  });
  @override
  List<Object?> get props => [cityName, lat, lon];
}

class LocationError extends LocationState {
  final String errorMessage;
  LocationError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
