import 'package:weather_app/features/weather/models/precipitation_model.dart';
import 'package:weather_app/features/weather/models/temperature_model.dart';
import 'package:weather_app/features/weather/models/weather_condition_model.dart';
import 'package:weather_app/features/weather/models/weather_response_model.dart';

class WeatherDataModel {
  final int dt;
  final int? sunrise;
  final int? sunset;
  final int? moonrise;
  final int? moonset;
  final double? moonPhase;

  final TemperatureModel temp;
  final TemperatureModel feelsLike;

  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final double? windGust;
  final int windDeg;
  final double? pop; // Probability of precipitation

  final PrecipitationModel? rain;
  final PrecipitationModel? snow;
  final List<WeatherConditionModel> weather;
  final List<String>? alerts;

  WeatherDataModel({
    required this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    this.windGust,
    required this.windDeg,
    this.pop,
    this.rain,
    this.snow,
    required this.weather,
    this.alerts,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      dt: json['dt'] as int? ?? 0,
      sunrise: json['sunrise'] as int?,
      sunset: json['sunset'] as int?,
      moonrise: json['moonrise'] as int?,
      moonset: json['moonset'] as int?,
      moonPhase: (json['moon_phase'] as num?)?.toDouble(),

      temp: TemperatureModel.fromJson(json['temp']),
      feelsLike: TemperatureModel.fromJson(json['feels_like']),

      pressure: (json['pressure'] as num?)?.toInt() ?? 0,
      humidity: (json['humidity'] as num?)?.toInt() ?? 0,
      dewPoint: (json['dew_point'] as num?)?.toDouble() ?? 0.0,
      uvi: (json['uvi'] as num?)?.toDouble() ?? 0.0,
      clouds: (json['clouds'] as num?)?.toInt() ?? 0,
      visibility: (json['visibility'] as num?)?.toInt() ?? 0,
      windSpeed: (json['wind_speed'] as num?)?.toDouble() ?? 0.0,
      windGust: (json['wind_gust'] as num?)?.toDouble(),
      windDeg: (json['wind_deg'] as num?)?.toInt() ?? 0,
      pop: (json['pop'] as num?)?.toDouble(),

      rain: json['rain'] != null
          ? PrecipitationModel.fromJson(json['rain'])
          : null,
      snow: json['snow'] != null
          ? PrecipitationModel.fromJson(json['snow'])
          : null,

      weather: json['weather'] != null
          ? (json['weather'] as List)
                .map<WeatherConditionModel>(
                  (x) => WeatherConditionModel.fromJson(x),
                )
                .toList()
          : [],
      alerts: json['alerts'] != null ? List<String>.from(json['alerts']) : null,
    );
  }

  static WeatherDataModel get dummy => WeatherDataModel(
    dt: 1787575190,
    temp: TemperatureModel(current: 25.0, min: 15.0, max: 28.0),
    feelsLike: TemperatureModel(current: 22.0),
    pressure: 1012,
    humidity: 50,
    dewPoint: 10.0,
    uvi: 5.0,
    clouds: 20,
    visibility: 10000,
    windSpeed: 4.5,
    windDeg: 180,
    pop: 0.2,
    weather: [
      WeatherConditionModel(
        id: 800,
        main: 'Clear',
        description: 'Loading...',
        icon: '01d',
      ),
    ],
  );
}
