import 'package:dio/dio.dart';
import 'package:weather_app/core/network/dio_helper.dart';
import 'package:weather_app/features/weather/models/weather_model.dart';

class WeatherService {
  static Future<WeatherResponse> getCurrentWeather(
    double lat,
    double lon,
  ) async {
    try {
      String url =
          "https://api.openweathermap.org/data/4.0/onecall/current?lat=$lat&lon=$lon&units=metric&appid=ef0ef81a018c79379c78f8c8b1874be7";
      Response response = await DioHelper.getData(url: url);
      return WeatherResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load current weather data: $e');
    }
  }

  static Future<WeatherResponse> getHourlyWeather(
    double lat,
    double lon,
  ) async {
    try {
      String url =
          "https://api.openweathermap.org/data/4.0/onecall/timeline/1h?lat=$lat&lon=$lon&units=metric&appid=ef0ef81a018c79379c78f8c8b1874be7";
      Response response = await DioHelper.getData(url: url);
      return WeatherResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load hourly weather data: $e');
    }
  }

  static Future<WeatherResponse> getDailyWeather(double lat, double lon) async {
    try {
      String url =
          "https://api.openweathermap.org/data/4.0/onecall/timeline/1day?lat=$lat&lon=$lon&units=metric&appid=ef0ef81a018c79379c78f8c8b1874be7";
      Response response = await DioHelper.getData(url: url);
      return WeatherResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load daily timeline: $e');
    }
  }
}
