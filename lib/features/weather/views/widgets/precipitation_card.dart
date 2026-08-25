import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/models/weather_model.dart';

class PrecipitationCard extends StatelessWidget {
  final List<WeatherData> hourlyData;
  const PrecipitationCard({super.key, required this.hourlyData});
  @override
  Widget build(BuildContext context) {
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
            color: const Color(0xFF1E2432),
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: next6Hours.map((item) {
              final date = DateTime.fromMillisecondsSinceEpoch(item.dt * 1000);
              final timeText = DateFormat('h a').format(date).toLowerCase();
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
