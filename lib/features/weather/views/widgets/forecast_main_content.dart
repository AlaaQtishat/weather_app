import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/cubit/weather_state.dart';
import 'package:weather_app/features/weather/views/widgets/forecast_daily_card.dart';
import 'package:weather_app/features/weather/views/widgets/forecast_today_card.dart';

class ForecastMainContent extends StatelessWidget {
  final WeatherLoaded state;

  const ForecastMainContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    double weekMin = state.daily.data
        .map((d) => d.temp.min?.toDouble() ?? 0.0)
        .reduce((a, b) => a < b ? a : b);

    double weekMax = state.daily.data
        .map((d) => d.temp.max?.toDouble() ?? 0.0)
        .reduce((a, b) => a > b ? a : b);

    double tempRange = (weekMax - weekMin) == 0 ? 1 : (weekMax - weekMin);

    return Column(
      children: [
        ForecastTodayCard(
          iconCode: state.current.data.first.weather.first.icon,
          temp: "${state.current.data.first.temp.current?.round() ?? 0}",
          desc: state.current.data.first.weather.first.description,
          max: "${state.daily.data.first.temp.max?.round() ?? '--'}",
          min: "${state.daily.data.first.temp.min?.round() ?? '--'}",
        ),

        SizedBox(height: 24.h),

        Row(
          children: [
            Text(
              "This week",
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Divider(color: Colors.grey.withOpacity(0.4), thickness: 1),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.daily.data.length > 1
              ? state.daily.data.length - 1
              : 0,
          itemBuilder: (context, index) {
            final dailyData = state.daily.data[index + 1];

            DateTime date = DateTime.fromMillisecondsSinceEpoch(
              dailyData.dt * 1000,
            );
            String dayName = DateFormat('EEE').format(date);
            String formattedDate = DateFormat('MMM d').format(date);

            double dayMin = dailyData.temp.min?.toDouble() ?? 0.0;
            double dayMax = dailyData.temp.max?.toDouble() ?? 0.0;

            double startFraction = (dayMin - weekMin) / tempRange;
            double widthFraction = (dayMax - dayMin) / tempRange;

            Color barColor = Colors.blueAccent;

            if (dayMax < 15) {
              barColor = Colors.blueAccent;
            } else if (dayMax >= 15 && dayMax < 19) {
              barColor = Colors.teal.shade300;
            } else if (dayMax >= 19 && dayMax < 24) {
              barColor = Colors.orangeAccent;
            } else {
              barColor = Colors.deepOrange;
            }
            return ForecastDailyCard(
              day: dayName,
              date: formattedDate,
              iconCode: dailyData.weather.first.icon,
              condition: dailyData.weather.first.main,
              minTemp: "${dayMin.round()}",
              maxTemp: "${dayMax.round()}",
              barColor: barColor,
              startFraction: startFraction.clamp(0.0, 1.0),
              widthFraction: widthFraction.clamp(0.0, 1.0),
            );
          },
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
