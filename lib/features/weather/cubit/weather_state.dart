import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/models/weather_model.dart';

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
  final WeatherModel weather;
  WeatherLoaded(this.weather);
  @override
  List<Object?> get props => [weather];
}

class WeatherError extends WeatherState {
  final String errorMessage;
  WeatherError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
