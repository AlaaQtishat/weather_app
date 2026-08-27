import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/search/cubit/search_cubit.dart';
import 'package:weather_app/features/search/services/recents_service.dart';
import 'package:weather_app/features/search/views/widgets/current_location_button.dart';
import 'package:weather_app/features/weather/views/city_weather_screen.dart';

class InitialSearchContent extends StatefulWidget {
  final TextEditingController searchController;
  const InitialSearchContent({super.key, required this.searchController});

  @override
  State<InitialSearchContent> createState() => _InitialSearchContentState();
}

class _InitialSearchContentState extends State<InitialSearchContent> {
  final RecentsService recentsService = RecentsService();

  List<Map<String, dynamic>> localRecents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    final data = await recentsService.getRecentSearches();
    if (mounted) {
      setState(() {
        localRecents = data;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: CurrentLocationButton(
            searchController: widget.searchController,
          ),
        ),
        SizedBox(height: 24.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "RECENT",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: AppTheme.primaryDarkBlue,
              ),
            ),

            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                setState(() {
                  localRecents.clear();
                });
                recentsService.clearAllRecents();
              },
              child: Text(
                "Clear All",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ),
          ],
        ),

        if (isLoading)
          Center(child: CircularProgressIndicator(color: AppTheme.primaryBlue))
        else if (localRecents.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Text(
              "No recent searches",
              style: TextStyle(color: Colors.grey, fontSize: 16.sp),
            ),
          )
        else
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: localRecents.length,
            itemBuilder: (context, index) {
              final item = localRecents[index];
              String cityName = item['name'];
              String countryName = item['country'];

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryDarkBlue.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.history_rounded,
                    color: AppTheme.primaryDarkBlue,
                    size: 22.sp,
                  ),
                ),
                title: Text(
                  cityName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryDarkBlue,
                  ),
                ),
                subtitle: Text(
                  countryName,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey.shade400,
                    size: 20.sp,
                  ),
                  onPressed: () {
                    setState(() {
                      localRecents.removeAt(index);
                    });
                    recentsService.removeRecentSearch(cityName, countryName);
                  },
                ),
                onTap: () {
                  widget.searchController.text = item['name'];
                  FocusManager.instance.primaryFocus?.unfocus();

                  double lat = item['lat'];
                  double lon = item['lon'];

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CityWeatherScreen(
                        lat: lat,
                        lon: lon,
                        cityName: cityName,
                        country: countryName,
                      ),
                    ),
                  );

                  Future.delayed(const Duration(seconds: 2), () {
                    widget.searchController.clear();
                    context.read<SearchCubit>().resetSearch();
                  });
                  recentsService.saveRecentSearches(
                    cityName,
                    countryName,
                    lat,
                    lon,
                  );
                },
              );
            },
          ),
      ],
    );
  }
}
