import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/app%20preferences/cubit/preferences_cubit.dart';
import 'package:weather_app/core/utils/weather_assets.dart';

class ForecastTodayCard extends StatelessWidget {
  final String iconCode;
  final String temp;
  final String desc;
  final String max;
  final String min;
  const ForecastTodayCard({
    super.key,
    required this.iconCode,
    required this.temp,
    required this.desc,
    required this.max,
    required this.min,
  });

  @override
  Widget build(BuildContext context) {
    final String tempUnit = context.select(
      (PreferencesCubit c) => c.state.tempUnit,
    );
    final bool isCelsius = tempUnit == "metric";
    String formattedDate = DateFormat('EEE d MMM').format(DateTime.now());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Container(
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            WeatherAssets.getCustomIcon(iconCode),
            width: 70.w,
            height: 70.h,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.cloud, size: 70.w, color: Colors.grey),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    isCelsius ? "$temp°C" : "$temp°F",
                    style: TextStyle(
                      fontSize: 42.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                    ),
                  ),
                ),
                Text(
                  desc,
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: 12.sp,
                      color: isDark ? Colors.white70 : Colors.grey,
                    ),
                    Text(
                      isCelsius ? " $max°C   " : " $max°F   ",
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                    Icon(
                      Icons.arrow_downward,
                      size: 12.sp,
                      color: isDark ? Colors.white70 : Colors.grey,
                    ),
                    Text(
                      isCelsius ? " $min°C" : " $min°F",
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Today",
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.grey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                formattedDate,
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.grey,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
