import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/app%20preferences/cubit/preferences_cubit.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/utils/weather_assets.dart';
import 'package:weather_app/features/weather/models/weather_data_model.dart';

class HourlyWeatherList extends StatelessWidget {
  final List<WeatherDataModel> hourlyData;
  final VoidCallback onForecastTap;
  const HourlyWeatherList({
    super.key,
    required this.hourlyData,
    required this.onForecastTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final String tempUnit = context.select(
      (PreferencesCubit c) => c.state.tempUnit,
    );
    final bool isCelsius = tempUnit == "metric";
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "HOURLY",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : AppTheme.primaryDarkBlue,
                letterSpacing: 1.2,
              ),
            ),
            GestureDetector(
              onTap: onForecastTap,
              child: Text(
                "10-day forecast",
                style: TextStyle(
                  decorationColor: isDark
                      ? AppTheme.primaryLightBlue
                      : AppTheme.primaryBlue,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppTheme.primaryLightBlue
                      : AppTheme.primaryBlue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 140.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: hourlyData.length,
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final item = hourlyData[index];
              final itemDateTime = DateTime.fromMillisecondsSinceEpoch(
                item.dt * 1000,
              );
              final now = DateTime.now();
              final bool isNow =
                  itemDateTime.hour == now.hour &&
                  itemDateTime.day == now.day &&
                  itemDateTime.month == now.month;

              final timeText = isNow
                  ? "NOW"
                  : DateFormat('ha').format(itemDateTime);

              return Container(
                width: 75.w,
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 6.w),
                decoration: BoxDecoration(
                  color: isNow
                      ? isDark
                            ? Color(0xFF7AB3E0).withOpacity(0.25)
                            : Colors.blue.shade50
                      : theme.cardColor,
                  borderRadius: BorderRadius.circular(20.r),
                  border: isNow
                      ? isDark
                            ? BoxBorder.all(color: Color(0xFF48618A), width: 2)
                            : Border.all(color: Colors.blue.shade400, width: 2)
                      : isDark
                      ? BoxBorder.all(color: Colors.white24)
                      : Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    isDark
                        ? BoxShadow(color: Colors.transparent)
                        : BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 1),
                          ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      timeText,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: isNow
                            ? isDark
                                  ? AppTheme.primaryLightBlue
                                  : Colors.blue.shade700
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Image.asset(
                      WeatherAssets.getCustomIcon(item.weather.first.icon),
                      width: 34.w,
                      height: 34.h,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.cloud, size: 28),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      isCelsius
                          ? "${item.temp.current.round()}°C"
                          : "${item.temp.current.round()}°F",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "${item.humidity}%",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: isNow
                            ? isDark
                                  ? AppTheme.primaryLightBlue
                                  : Colors.blue.shade300
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
