import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/features/location/cubit/location_cubit.dart';
import 'package:weather_app/features/location/cubit/location_state.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/cubit/weather_state.dart';
import 'package:weather_app/features/weather/models/weather_model.dart';
import 'package:weather_app/features/weather/views/widgets/custom_error_widget.dart';
import 'package:weather_app/features/weather/views/widgets/weather_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    final locationState = context.watch<LocationCubit>().state;
    final weatherState = context.watch<WeatherCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: ContainerBackground(
        content: BlocListener<LocationCubit, LocationState>(
          listener: (context, locState) {
            if (locState is LocationLoaded) {
              context.read<WeatherCubit>().fetchWeatherData(
                locState.lat,
                locState.lon,
              );
            }
          },
          child: _buildMainContent(context, locationState, weatherState),
        ),
      ),
    );
  }

  Widget _buildMainContent(
    BuildContext context,
    LocationState locationState,
    WeatherState weatherState,
  ) {
    if (locationState is LocationError) {
      final errorMsg = locationState.errorMessage.toLowerCase();
      final isGpsOff = errorMsg.contains('disabled');
      final isDeniedForever = errorMsg.contains('permanently');

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
        onPressed: () => context.read<LocationCubit>().fetchUserLocation(),
      );
    }

    if (locationState is LocationLoading || locationState is LocationInitial) {
      return Skeletonizer(
        enabled: true,
        child: WeatherContent(
          onRefresh: () async {
            final locationState = context.read<LocationCubit>().state;

            if (locationState is LocationLoaded) {
              await context.read<WeatherCubit>().fetchWeatherData(
                locationState.lat,
                locationState.lon,
              );
            } else {
              await context.read<LocationCubit>().fetchUserLocation();
            }
          },

          currentData: WeatherData.dummy,
          todayData: WeatherData.dummy,
          hourlyData: List.generate(5, (index) => WeatherData.dummy),
          isHomeScreen: true,
        ),
      );
    }

    if (locationState is LocationLoaded) {
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
            context.read<WeatherCubit>().fetchWeatherData(
              locationState.lat,
              locationState.lon,
            );
          },
        );
      }
      if (weatherState is WeatherLoading || weatherState is WeatherInitial) {
        return Skeletonizer(
          enabled: true,
          child: WeatherContent(
            onRefresh: () async {
              final locationState = context.read<LocationCubit>().state;

              if (locationState is LocationLoaded) {
                await context.read<WeatherCubit>().fetchWeatherData(
                  locationState.lat,
                  locationState.lon,
                );
              } else {
                await context.read<LocationCubit>().fetchUserLocation();
              }
            },
            currentData: WeatherData.dummy,
            todayData: WeatherData.dummy,
            hourlyData: List.generate(5, (index) => WeatherData.dummy),
            isHomeScreen: true,
          ),
        );
      }

      if (weatherState is WeatherLoaded) {
        return WeatherContent(
          onRefresh: () async {
            final locationState = context.read<LocationCubit>().state;

            if (locationState is LocationLoaded) {
              await context.read<WeatherCubit>().fetchWeatherData(
                locationState.lat,
                locationState.lon,
              );
            } else {
              await context.read<LocationCubit>().fetchUserLocation();
            }
          },
          currentData: weatherState.current.data.first,
          todayData: weatherState.daily.data.first,
          hourlyData: weatherState.hourly.data,
          isHomeScreen: true,
        );
      }
    }

    return const SizedBox();
  }
}
