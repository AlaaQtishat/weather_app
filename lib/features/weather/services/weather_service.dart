import 'package:dio/dio.dart';
import 'package:weather_app/core/constants/api_constants.dart';
import 'package:weather_app/core/network/dio_helper.dart';
import 'package:weather_app/features/weather/models/weather_model.dart';

class WeatherService {
  static Exception _handleDioError(dynamic e) {
    if (e is DioException) {
      String errorMessage = "Oops! We couldn't fetch the weather.";

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        errorMessage = "Please check your internet connection and try again.";
      } else if (e.type == DioExceptionType.badResponse) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          errorMessage =
              "Service temporarily unavailable. Please try again later.";
        } else if (statusCode == 500 || statusCode == 502) {
          errorMessage = "Server error. Our team is working on it.";
        }
      }
      print(e);
      return Exception(errorMessage);
    }

    print(e);
    return Exception('Unexpected error occurred. Please try again.');
  }

  static Future<WeatherResponse> getCurrentWeather(
    double lat,
    double lon,
    String units,
  ) async {
    try {
      String url =
          "${ApiConstants.baseUrl}/current?lat=$lat&lon=$lon&units=$units&appid=${ApiConstants.apiKey}";
      Response response = await DioHelper.getData(url: url);
      return WeatherResponse.fromJson(response.data);
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  static Future<WeatherResponse> getHourlyWeather(
    double lat,
    double lon,
    String units,
  ) async {
    try {
      String url =
          "${ApiConstants.baseUrl}/timeline/1h?lat=$lat&lon=$lon&units=$units&appid=${ApiConstants.apiKey}";
      Response response = await DioHelper.getData(url: url);
      return WeatherResponse.fromJson(response.data);
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  static Future<WeatherResponse> getDailyWeather(
    double lat,
    double lon,
    String units,
  ) async {
    try {
      String url =
          "${ApiConstants.baseUrl}/timeline/1day?lat=$lat&lon=$lon&units=$units&appid=${ApiConstants.apiKey}";
      Response response = await DioHelper.getData(url: url);
      return WeatherResponse.fromJson(response.data);
    } catch (e) {
      throw _handleDioError(e);
    }
  }
}
