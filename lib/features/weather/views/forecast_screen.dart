import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/app%20preferences/cubit/preferences_cubit.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/utils/weather_assets.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/features/location/cubit/location_cubit.dart';
import 'package:weather_app/features/location/cubit/location_state.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/cubit/weather_state.dart';
import 'package:weather_app/features/weather/views/widgets/custom_error_widget.dart';
import 'package:weather_app/features/weather/views/widgets/custom_skeletonizer.dart';
import 'package:weather_app/features/weather/views/widgets/forecast_today_card.dart';
import 'package:weather_app/core/widgets/header_section.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locationState = context.read<LocationCubit>().state;
      if (locationState is LocationLoaded) {
        context.read<WeatherCubit>().fetchWeatherData(
          locationState.lat,
          locationState.lon,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerBackground(
        content: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  HeaderSection(isHome: false),
                  SizedBox(height: 24.h),

                  BlocConsumer<LocationCubit, LocationState>(
                    listener: (context, locState) {
                      if (locState is LocationLoaded) {
                        context.read<WeatherCubit>().fetchWeatherData(
                          locState.lat,
                          locState.lon,
                        );
                      }
                    },
                    builder: (context, locState) {
                      if (locState is LocationError) {
                        final errorMsg = locState.errorMessage.toLowerCase();
                        final isGpsOff = errorMsg.contains('disabled');
                        final isDeniedForever = errorMsg.contains(
                          'permanently',
                        );

                        return CustomErrorWidget(
                          icon: isGpsOff
                              ? Icons.gps_off_rounded
                              : (isDeniedForever
                                    ? Icons.block_flipped
                                    : Icons.location_off_rounded),
                          title: isGpsOff
                              ? "GPS is Disabled"
                              : (isDeniedForever
                                    ? "Permission Blocked"
                                    : "Location Access Denied"),
                          message: isGpsOff
                              ? "Please turn on your GPS from the quick settings and try again."
                              : (isDeniedForever
                                    ? "Location is permanently denied.\nPlease go to your device Settings to allow access."
                                    : "Please allow location permissions to get your local weather."),
                          buttonText: "Try Again",
                          onPressed: () =>
                              context.read<LocationCubit>().fetchUserLocation(),
                        );
                      }

                      if (locState is LocationLoading ||
                          locState is LocationInitial) {
                        return const CustomSkeletonizer(
                          child: DummyForecastContent(),
                        );
                      }

                      if (locState is LocationLoaded) {
                        return BlocBuilder<WeatherCubit, WeatherState>(
                          builder: (context, weatherState) {
                            if (weatherState is WeatherError) {
                              final cleanMessage = weatherState.errorMessage
                                  .replaceAll('Exception: ', '');
                              return CustomErrorWidget(
                                icon: Icons.cloud_off_rounded,
                                title: "Oops! We couldn't fetch the weather.",
                                message: cleanMessage,
                                buttonText: "Try Again",
                                onPressed: () {
                                  context.read<WeatherCubit>().fetchWeatherData(
                                    locState.lat,
                                    locState.lon,
                                  );
                                },
                              );
                            }
                            if (weatherState is WeatherLoaded) {
                              return MainForecastContent(state: weatherState);
                            }
                            return const CustomSkeletonizer(
                              child: DummyForecastContent(),
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainForecastContent extends StatelessWidget {
  final WeatherLoaded state;

  const MainForecastContent({super.key, required this.state});

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
            return DailyForecastCard(
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
      ],
    );
  }
}

class DailyForecastCard extends StatelessWidget {
  final String day;
  final String date;
  final String iconCode;
  final String condition;
  final String minTemp;
  final String maxTemp;
  final Color barColor;
  final double startFraction;
  final double widthFraction;

  const DailyForecastCard({
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
        border: isDark ? BoxBorder.all(color: Colors.white24) : Border(),
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

class DummyForecastContent extends StatelessWidget {
  const DummyForecastContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 130.h,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Text("This week", style: TextStyle(fontSize: 14.sp)),
            SizedBox(width: 16.w),
            Expanded(child: Divider()),
          ],
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 9,
          itemBuilder: (context, index) => Container(
            height: 60.h,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
      ],
    );
  }
}
