import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/app%20preferences/cubit/preferences_cubit.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/weather/models/weather_data_model.dart';

class PrecipitationCard extends StatelessWidget {
  final List<WeatherDataModel> hourlyData;
  const PrecipitationCard({super.key, required this.hourlyData});
  @override
  Widget build(BuildContext context) {
    final timeFormatPref = context.select(
      (PreferencesCubit c) => c.state.timeFormat,
    );
    final chartTimeFormat = DateFormat(
      timeFormatPref == '12h' ? 'h a' : 'HH:00',
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    if (hourlyData.isEmpty) return const SizedBox();
    final next6Hours = hourlyData.take(6).toList();

    double maxRain = 0;
    for (var item in next6Hours) {
      if ((item.rain?.h1 ?? 0) > maxRain) {
        maxRain = item.rain!.h1;
      }
    }
    if (maxRain == 0) maxRain = 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PRECIPITATION",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white70 : AppTheme.primaryDarkBlue,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
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
            border: isDark ? Border.all(color: Colors.white24) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: next6Hours.map((item) {
              final date = DateTime.fromMillisecondsSinceEpoch(item.dt * 1000);
              final timeText = chartTimeFormat.format(date).toLowerCase();
              final rainValue = item.rain?.h1 ?? 0.0;

              double barHeight = rainValue == 0
                  ? 3.h
                  : (rainValue / maxRain) * 60.h;

              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    timeText,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: 38.w,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300.withOpacity(
                        rainValue > 0 ? 1 : 0.5,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    rainValue.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
