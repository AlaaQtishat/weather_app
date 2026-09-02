import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/core/widgets/header_section.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/cubit/weather_state.dart';
import 'package:weather_app/features/weather/views/widgets/custom_error_widget.dart';
import 'package:weather_app/features/weather/views/widgets/custom_skeletonizer.dart';
import 'package:weather_app/features/weather/views/widgets/dummy_forecast_content.dart';
import 'package:weather_app/features/weather/views/widgets/forecast_main_content.dart';

class CityForecastScreen extends StatefulWidget {
  final double lon;
  final double lat;
  final String cityName;

  const CityForecastScreen({
    super.key,
    required this.lon,
    required this.lat,
    required this.cityName,
  });

  @override
  State<CityForecastScreen> createState() => _CityForecastScreenState();
}

class _CityForecastScreenState extends State<CityForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WeatherCubit()..fetchWeatherData(widget.lat, widget.lon),
      child: Scaffold(
        body: ContainerBackground(
          content: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: HeaderSection(
                      isHome: false,
                      showCloseButton: true,
                      cityName: widget.cityName,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  BlocBuilder<WeatherCubit, WeatherState>(
                    builder: (context, weatherState) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: buildMainContent(context, weatherState),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMainContent(BuildContext context, WeatherState weatherState) {
    if (weatherState is WeatherLoading || weatherState is WeatherInitial) {
      return const Center(
        child: CustomSkeletonizer(child: DummyForecastContent()),
      );
    }

    if (weatherState is WeatherError) {
      final cleanMessage = weatherState.errorMessage.replaceAll(
        'Exception: ',
        '',
      );
      return CustomErrorWidget(
        icon: Icons.cloud_off_rounded,
        title: "Oops! We couldn't fetch the weather.",
        message: cleanMessage,
        buttonText: "Try Again",
        onPressed: () {
          context.read<WeatherCubit>().fetchWeatherData(widget.lat, widget.lon);
        },
      );
    }

    if (weatherState is WeatherLoaded) {
      return ForecastMainContent(state: weatherState);
    }

    return const CustomSkeletonizer(child: DummyForecastContent());
  }
}
