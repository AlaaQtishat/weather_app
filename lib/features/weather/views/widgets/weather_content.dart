import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/widgets/header_section.dart';
import 'package:weather_app/features/main_layout/cubit/navigation_cubit.dart';
import 'package:weather_app/features/weather/models/weather_model.dart';
import 'package:weather_app/features/weather/views/forecast_screen.dart';
import 'package:weather_app/features/weather/views/widgets/current_weather_card.dart';
import 'package:weather_app/features/weather/views/widgets/hourly_weather_list.dart';
import 'package:weather_app/features/weather/views/widgets/precipitation_card.dart';
import 'package:weather_app/features/weather/views/widgets/rain_alert_card.dart';
import 'package:weather_app/features/weather/views/widgets/sunrise_sunset_card.dart';
import 'package:weather_app/features/weather/views/widgets/weather_details_grid.dart';

class WeatherContent extends StatelessWidget {
  final WeatherData currentData;
  final WeatherData todayData;
  final List<WeatherData> hourlyData;
  final Future<void> Function()? onRefresh;
  final bool isHomeScreen;
  final String? cityName;
  final String? country;
  final VoidCallback onForecastTap;
  WeatherContent({
    super.key,
    required this.currentData,
    required this.todayData,
    required this.hourlyData,
    this.onRefresh,
    this.isHomeScreen = false,
    this.cityName,
    this.country,
    required this.onForecastTap,
  });
  final DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(now);
    final rainValue = currentData.rain?.h1 ?? 0.0;
    final bool showRainAlert = rainValue > 0;
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),

              HeaderSection(
                isHome: true,
                cityName: cityName,
                showCloseButton: !isHomeScreen,
              ),

              SizedBox(height: 30.h),

              CurrentWeatherCard(
                currentData: currentData,
                todayData: todayData,
              ),

              if (showRainAlert) ...[
                SizedBox(height: 16.h),
                RainAlertCard(rainValue: rainValue),
              ],

              SizedBox(height: 24.h),

              HourlyWeatherList(
                hourlyData: hourlyData,
                onForecastTap: onForecastTap,
              ),

              SizedBox(height: 24.h),

              WeatherDetailsGrid(currentData: currentData),

              SizedBox(height: 24.h),

              SunriseSunsetCard(
                sunriseTimestamp: todayData.sunrise ?? currentData.sunrise ?? 0,
                sunsetTimestamp: todayData.sunset ?? currentData.sunset ?? 0,
              ),

              SizedBox(height: 24.h),

              if (showRainAlert) ...[
                SizedBox(height: 16.h),
                PrecipitationCard(hourlyData: hourlyData),
              ],

              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}
