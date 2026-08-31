import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/core/app%20preferences/cubit/preferences_cubit.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/weather/models/weather_model.dart';
import 'package:weather_app/core/utils/weather_assets.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherData currentData;
  final WeatherData todayData;

  const CurrentWeatherCard({
    super.key,
    required this.currentData,
    required this.todayData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final String tempUnit = context.select(
      (PreferencesCubit c) => c.state.tempUnit,
    );
    final bool isCelsius = tempUnit == "metric";
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          isDark
              ? BoxShadow(color: Colors.transparent)
              : BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
        ],
        border: isDark ? BoxBorder.all(color: Colors.white24) : Border(),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          currentData.weather.isNotEmpty
              ? Image.asset(
                  WeatherAssets.getCustomIcon(currentData.weather.first.icon),
                  width: 140.w,
                  height: 140.h,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      size: 80.w,
                      color: Colors.grey,
                    );
                  },
                )
              : Icon(Icons.cloud, size: 80.w, color: Colors.grey),

          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isCelsius
                      ? "${currentData.temp.current.round()}°C"
                      : "${currentData.temp.current.round()}°F",
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currentData.weather.isNotEmpty
                      ? currentData.weather.first.description.toUpperCase()
                      : "UNKNOWN",

                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      isCelsius
                          ? "↑ ${todayData.temp.max?.round() ?? '--'}°C"
                          : "↑ ${todayData.temp.max?.round() ?? '--'}°F",
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      isCelsius
                          ? "↓ ${todayData.temp.min?.round() ?? '--'}°C"
                          : "↓ ${todayData.temp.min?.round() ?? '--'}°F",
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.08)
                        : AppTheme.secondaryDarkBlue,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    isCelsius
                        ? "Feels ${currentData.feelsLike.current.round()}°C"
                        : "Feels ${currentData.feelsLike.current.round()}°F",
                    style: TextStyle(fontSize: 13.sp, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
