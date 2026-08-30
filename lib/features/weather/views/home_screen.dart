import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/features/location/cubit/location_cubit.dart';
import 'package:weather_app/features/location/cubit/location_state.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/cubit/weather_state.dart';
import 'package:weather_app/features/weather/models/weather_model.dart';
import 'package:weather_app/features/weather/views/widgets/custom_error_widget.dart';
import 'package:weather_app/features/weather/views/widgets/custom_skeletonizer.dart';
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
    return Scaffold(
      body: ContainerBackground(
        content: BlocConsumer<LocationCubit, LocationState>(
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
                onPressed: () =>
                    context.read<LocationCubit>().fetchUserLocation(),
              );
            }

            if (locState is LocationLoading || locState is LocationInitial) {
              return CustomSkeletonizer(
                child: WeatherContent(
                  currentData: WeatherData.dummy,
                  todayData: WeatherData.dummy,
                  hourlyData: List.generate(5, (index) => WeatherData.dummy),
                  isHomeScreen: true,
                ),
              );
            }

            if (locState is LocationLoaded) {
              final weatherState = context.watch<WeatherCubit>().state;

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
                      locState.lat,
                      locState.lon,
                    );
                  },
                );
              }
              if (weatherState is WeatherLoading ||
                  weatherState is WeatherInitial) {
                return CustomSkeletonizer(
                  child: WeatherContent(
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
                    final currentLocState = context.read<LocationCubit>().state;

                    if (currentLocState is LocationLoaded) {
                      await context.read<WeatherCubit>().fetchWeatherData(
                        currentLocState.lat,
                        currentLocState.lon,
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
          },
        ),
      ),
    );
  }
}
