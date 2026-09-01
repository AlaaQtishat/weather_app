import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/models/weather_response_model.dart';

class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoaded extends WeatherState {
  final WeatherResponseModel current;

  final WeatherResponseModel hourly;

  final WeatherResponseModel daily;
  final String units;
  WeatherLoaded({
    required this.current,
    required this.hourly,
    required this.daily,
    required this.units,
  });

  @override
  List<Object?> get props => [current, hourly, daily, units];
}

class WeatherError extends WeatherState {
  final String errorMessage;
  WeatherError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
