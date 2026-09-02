import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/cubit/weather_state.dart';
import 'package:weather_app/features/weather/views/city_forecast_Screen.dart';
import 'package:weather_app/features/weather/views/widgets/custom_error_widget.dart';
import 'package:weather_app/features/weather/views/widgets/weather_content.dart';

class CityWeatherScreen extends StatelessWidget {
  final double lon;
  final double lat;
  final String cityName;
  final String country;
  CityWeatherScreen({
    super.key,
    required this.lon,
    required this.lat,
    required this.cityName,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..fetchWeatherData(lat, lon),
      child: Scaffold(
        body: ContainerBackground(
          content: BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, weatherState) {
              return buildMainContent(context, weatherState);
            },
          ),
        ),
      ),
    );
  }

  Widget buildMainContent(BuildContext context, WeatherState weatherState) {
    if (weatherState is WeatherLoading || weatherState is WeatherInitial) {
      return Center(
        child: CircularProgressIndicator(color: AppTheme.primaryBlue),
      );
    }

    if (weatherState is WeatherError) {
      final cleanMessage = weatherState.errorMessage.replaceAll(
        'Exception: ',
        '',
      );
      return CustomErrorWidget(
        icon: Icons.cloud_off_rounded,
        title: "Oops! We couldn't fetch the weather.",
        message: cleanMessage,
        buttonText: "Try Again",
        onPressed: () {
          context.read<WeatherCubit>().fetchWeatherData(lat, lon);
        },
      );
    }

    if (weatherState is WeatherLoaded) {
      return WeatherContent(
        onForecastTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  CityForecastScreen(lat: lat, lon: lon, cityName: cityName),
            ),
          );
        },
        onRefresh: () async {
          await context.read<WeatherCubit>().fetchWeatherData(lat, lon);
        },
        currentData: weatherState.current.data.first,
        todayData: weatherState.daily.data.first,
        hourlyData: weatherState.hourly.data,
        cityName: cityName,
        country: country,
      );
    }
    return const SizedBox();
  }
}
