import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/weather/models/weather_model.dart';
import 'package:weather_app/features/weather/views/widgets/details_card.dart';

class WeatherDetailsGrid extends StatelessWidget {
  final WeatherData currentData;
  const WeatherDetailsGrid({super.key, required this.currentData});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final visibilityKm = (currentData.visibility / 1000).toStringAsFixed(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "DETAILS",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white70 : AppTheme.primaryDarkBlue,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 12.h),
        GridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 1.35,
          children: [
            DetailsCard(
              title: "• HUMIDITY",
              measurement: "%",
              value: "${currentData.humidity}",
              subtitle: currentData.humidity > 60 ? "High" : "Moderate",
            ),
            DetailsCard(
              title: "• WIND",
              measurement: "m/s",
              value: "${currentData.windSpeed}",
              subtitle: "Deg: ${currentData.windDeg}°",
            ),
            DetailsCard(
              title: "• PRESSURE",
              measurement: "hPa",
              value: "${currentData.pressure}",
              subtitle: "Sea level",
            ),
            DetailsCard(
              title: "• VISIBILITY",
              measurement: "km",
              value: "$visibilityKm",
              subtitle: currentData.visibility > 8000 ? "Clear sight" : "Hazy",
            ),
          ],
        ),
      ],
    );
  }
}
