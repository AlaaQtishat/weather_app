import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/features/search/cubit/recents_cubit.dart';
import 'package:weather_app/features/search/cubit/search_cubit.dart';
import 'package:weather_app/features/search/services/recents_service.dart';
import 'package:weather_app/features/weather/views/city_weather_screen.dart';

class SearchResultsList extends StatelessWidget {
  final List<dynamic> results;
  final TextEditingController searchController;

  SearchResultsList({
    super.key,
    required this.results,
    required this.searchController,
  });
  // RecentsService recentsService = RecentsService();
  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Center(
        child: Column(
          children: [
            SizedBox(height: 150.h),
            Icon(Icons.search_off_outlined, size: 80.sp, color: Colors.grey),
            SizedBox(height: 4.h),
            Text(
              "No places found!",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final cityName = results[index].name.toString();
          final countryCode = results[index].country.toString();
          final country = CountryService().findByCode(countryCode);
          final fullCountryName = country?.name ?? countryCode;
          final flagEmoji = country?.flagEmoji ?? '📍';

          return ListTile(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              double lat = results[index].lat;
              double lon = results[index].lon;

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CityWeatherScreen(
                    lat: lat,
                    lon: lon,
                    cityName: cityName,
                    country: fullCountryName,
                  ),
                ),
              );

              Future.delayed(const Duration(seconds: 2), () {
                searchController.clear();
                context.read<SearchCubit>().resetSearch();
              });
              context.read<RecentsCubit>().saveRecent(
                cityName,
                fullCountryName,
                lat,
                lon,
              );
            },
            leading: Text(flagEmoji, style: TextStyle(fontSize: 28.sp)),
            title: Text(cityName),
            subtitle: Text(fullCountryName),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
            ),
          );
        },
      );
    }
  }
}
