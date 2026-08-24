import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/core/widgets/header_section.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/cubit/weather_state.dart';
import 'package:weather_app/features/weather/models/weather_model.dart';
import 'package:weather_app/features/weather/views/widgets/current_weather_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerBackground(
        content: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 60.h),
                HeaderSection(isHome: true),
                SizedBox(height: 30.h),

                BlocBuilder<WeatherCubit, WeatherState>(
                  builder: (context, state) {
                    final isLoading =
                        state is WeatherLoading || state is WeatherInitial;

                    if (state is WeatherError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_off_rounded,
                              size: 80.w,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "Oops! We couldn't fetch the weather.",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E2432),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Please check your internet connection\nand try again.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            ElevatedButton.icon(
                              onPressed: () {
                                context.read<WeatherCubit>().fetchWeatherData();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E2432),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                  vertical: 12.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Try Again",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    final currentWeatherData = (state is WeatherLoaded)
                        ? state.current.data.first
                        : WeatherData.dummy;

                    final todayTimelineData = (state is WeatherLoaded)
                        ? state.daily.data.first
                        : WeatherData.dummy;

                    return Skeletonizer(
                      enabled: isLoading,
                      child: CurrentWeatherCard(
                        currentData: currentWeatherData,
                        todayData: todayTimelineData,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
