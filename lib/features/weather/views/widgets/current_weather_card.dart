import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
    //final isSkeleton = Skeletonizer.of(context).enabled;

    return Container(
      padding: EdgeInsets.all(20.w),
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

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${currentData.temp.current.round()}°",
                style: TextStyle(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E2432),
                ),
              ),
              Text(
                currentData.weather.isNotEmpty
                    ? currentData.weather.first.description.toUpperCase()
                    : "UNKNOWN",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E2432),
                ),
              ),
              SizedBox(height: 8.h),

              Row(
                children: [
                  Text(
                    "↑ ${todayData.temp.max?.round() ?? '--'}°",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "↓ ${todayData.temp.min?.round() ?? '--'}°",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color:
                      // isSkeleton
                      //     ? Colors.grey.shade200
                      //     :
                      const Color(0xFF1E2432),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  "Feels ${currentData.feelsLike.current.round()}°",
                  style: TextStyle(
                    color:
                        // isSkeleton ? Colors.grey.shade400 :
                        Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
