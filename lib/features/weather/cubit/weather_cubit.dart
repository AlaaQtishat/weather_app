import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/cubit/weather_state.dart';
import 'package:weather_app/features/weather/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  Future<void> fetchWeatherData(double lat, double lon) async {
    emit(WeatherLoading());
    try {
      final currentData = await WeatherService.getCurrentWeather(lat, lon);
      final hourlyData = await WeatherService.getHourlyWeather(lat, lon);
      final dailyData = await WeatherService.getDailyWeather(lat, lon);

      emit(
        WeatherLoaded(
          current: currentData,
          hourly: hourlyData,
          daily: dailyData,
        ),
      );
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
