import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/features/location/cubit/location_cubit.dart';
import 'package:weather_app/features/location/cubit/location_state.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/cubit/weather_state.dart';
import 'package:weather_app/features/weather/views/widgets/custom_error_widget.dart';
import 'package:weather_app/features/weather/views/widgets/custom_skeletonizer.dart';
import 'package:weather_app/features/weather/views/widgets/dummy_forecast_content.dart';
import 'package:weather_app/features/weather/views/widgets/forecast_main_content.dart';
import 'package:weather_app/core/widgets/header_section.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

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

                  BlocBuilder<LocationCubit, LocationState>(
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
                              return ForecastMainContent(state: weatherState);
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
