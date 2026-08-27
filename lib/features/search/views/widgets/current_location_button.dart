import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/location/cubit/location_cubit.dart';
import 'package:weather_app/features/location/cubit/location_state.dart';
import 'package:weather_app/features/search/cubit/recents_cubit.dart';
import 'package:weather_app/features/search/cubit/search_cubit.dart';
import 'package:weather_app/features/search/services/recents_service.dart';
import 'package:weather_app/features/weather/views/city_weather_screen.dart';

class CurrentLocationButton extends StatelessWidget {
  final TextEditingController searchController;
  CurrentLocationButton({super.key, required this.searchController});
  // RecentsService recentsService = RecentsService();
  @override
  Widget build(BuildContext context) {
    final locationState = context.watch<LocationCubit>().state;
    final isLoading = locationState is LocationLoading;

    return GestureDetector(
      onTap: isLoading
          ? null
          : () {
              if (locationState is LocationLoaded) {
                context.read<RecentsCubit>().saveRecent(
                  locationState.cityName,
                  locationState.countryName,
                  locationState.lat,
                  locationState.lon,
                );
                // searchController.text = locationState.cityName;
                // context.read<SearchCubit>().getSearchResult(
                //   locationState.cityName,
                // );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CityWeatherScreen(
                      lon: locationState.lon,
                      lat: locationState.lat,
                      cityName: locationState.cityName,
                      country: locationState.countryName,
                    ),
                  ),
                );
                // Future.delayed(const Duration(seconds: 2), () {
                //   searchController.clear();
                //   context.read<SearchCubit>().resetSearch();
                // });
                // recentsService.saveRecentSearches(
                //   locationState.cityName,
                //   locationState.countryName,
                //   locationState.lat,
                //   locationState.lon,
                // );
              } else {
                searchController.clear();
                context.read<SearchCubit>().resetSearch();
                context.read<LocationCubit>().fetchUserLocation();
              }
            },
      child: Row(
        children: [
          if (isLoading)
            SizedBox(
              width: 20.w,
              height: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppTheme.primaryBlue,
              ),
            )
          else
            Icon(Icons.my_location, color: AppTheme.primaryBlue, size: 20.sp),

          SizedBox(width: 8.w),

          Text(
            "Use my current location",
            style: TextStyle(
              color: isLoading ? Colors.grey : AppTheme.secondaryDarkBlue,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: isLoading ? Colors.grey : AppTheme.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}
