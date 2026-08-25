import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/utils/weather_assets.dart';
import 'package:weather_app/features/weather/models/weather_model.dart';
import 'package:weather_app/features/weather/views/forecast_screen.dart';

class HourlyWeatherList extends StatelessWidget {
  final List<WeatherData> hourlyData;
  const HourlyWeatherList({super.key, required this.hourlyData});

  @override
  Widget build(BuildContext context) {
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
                color: AppTheme.primaryDarkBlue,
                letterSpacing: 1.2,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ForecastScreen()),
                );
              },
              child: Text(
                "7-day forecast",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryBlue,
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
                      ? Colors.blue.shade50
                      : Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20.r),
                  border: isNow
                      ? Border.all(color: Colors.blue.shade400, width: 1.5)
                      : Border.all(color: Colors.grey.shade200),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
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
                        color: isNow ? Colors.blue.shade700 : Colors.grey,
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
                      "${item.temp.current.round()}°",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E2432),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "${item.humidity}%",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: isNow ? Colors.blue.shade300 : Colors.grey,
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
