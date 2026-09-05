import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/app%20preferences/cubit/preferences_cubit.dart';
import 'package:weather_app/core/utils/weather_assets.dart';

class ForecastDailyCard extends StatelessWidget {
  final String day;
  final String date;
  final String iconCode;
  final String condition;
  final String minTemp;
  final String maxTemp;
  final Color barColor;
  final double startFraction;
  final double widthFraction;

  const ForecastDailyCard({
    super.key,
    required this.day,
    required this.date,
    required this.iconCode,
    required this.condition,
    required this.minTemp,
    required this.maxTemp,
    required this.barColor,
    required this.startFraction,
    required this.widthFraction,
  });

  @override
  Widget build(BuildContext context) {
    final String tempUnit = context.select(
      (PreferencesCubit c) => c.state.tempUnit,
    );
    final bool isCelsius = tempUnit == "metric";
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final double totalBarWidth = 60.w;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 50.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),

          Image.asset(
            WeatherAssets.getCustomIcon(iconCode),
            width: 32.w,
            height: 32.h,
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Text(
              condition,
              style: TextStyle(color: Colors.grey, fontSize: 13.sp),
            ),
          ),
          SizedBox(width: 8.w),

          Text(
            isCelsius ? minTemp + "°C" : minTemp + "°F",
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            textAlign: TextAlign.right,
          ),
          SizedBox(width: 8.w),

          SizedBox(
            width: totalBarWidth,
            height: 4.h,
            child: Stack(
              children: [
                Container(
                  width: totalBarWidth,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                Positioned(
                  left: totalBarWidth * startFraction,
                  child: Container(
                    width: totalBarWidth * widthFraction,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),

          Text(
            isCelsius ? maxTemp + "°C" : maxTemp + "°F",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
