import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/app%20preferences/app_preferences_service.dart';
import 'package:weather_app/features/weather/cubit/weather_state.dart';
import 'package:weather_app/features/weather/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  Future<void> fetchWeatherData(double lat, double lon) async {
    AppPreferences prefs = AppPreferences();
    emit(WeatherLoading());
    try {
      final String units = await prefs.getTempUnit();
      final currentData = await WeatherService.getCurrentWeather(
        lat,
        lon,
        units,
      );
      final hourlyData = await WeatherService.getHourlyWeather(lat, lon, units);
      final dailyData = await WeatherService.getDailyWeather(lat, lon, units);

      emit(
        WeatherLoaded(
          current: currentData,
          hourly: hourlyData,
          daily: dailyData,
          units: units,
        ),
      );
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
