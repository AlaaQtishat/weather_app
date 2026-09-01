import 'package:weather_app/features/weather/models/weather_data_model.dart';

class WeatherResponseModel {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final List<WeatherDataModel> data;
  final String? prev;
  final String? next;

  WeatherResponseModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.data,
    this.prev,
    this.next,
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) {
    return WeatherResponseModel(
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      timezone: json['timezone'] as String? ?? '',
      timezoneOffset: json['timezone_offset'] as int? ?? 0,
      data: json['data'] != null
          ? List<WeatherDataModel>.from(
              (json['data'] as List).map((x) => WeatherDataModel.fromJson(x)),
            )
          : [],
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );
  }
}
