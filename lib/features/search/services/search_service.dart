import 'package:dio/dio.dart';
import 'package:weather_app/core/constants/api_constants.dart';
import 'package:weather_app/core/network/dio_helper.dart';
import 'package:weather_app/features/search/models/search_result_model.dart';

class SearchService {
  static Exception _handleDioError(dynamic e) {
    if (e is DioException) {
      String errorMessage = "Oops! We couldn't fetch the search result.";

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

  static Future<List<SearchResultModel>> getSearchResults(String name) async {
    try {
      String url =
          'http://api.openweathermap.org/geo/1.0/direct?q=$name&limit=5&appid=${ApiConstants.apiKey}';
      Response response = await DioHelper.getData(url: url);

      List<dynamic> data = response.data;
      return data.map((json) => SearchResultModel.fromJson(json)).toList();
    } catch (e) {
      throw _handleDioError(e);
    }
  }
}
