import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/utils/debouncer.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/features/search/cubit/search_cubit.dart';
import 'package:weather_app/features/search/cubit/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  @override
  void dispose() {
    searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ContainerBackground(
        content: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Find a city.",
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryDarkBlue,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "Search anywhere in the world",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppTheme.secondaryDarkBlue,
                ),
              ),
              SizedBox(height: 32.h),

              Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    if (value.trim().isEmpty) {
                      context.read<SearchCubit>().resetSearch();
                      return;
                    }

                    _debouncer.run(() {
                      context.read<SearchCubit>().getSearchResult(value);
                    });
                  },
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    hintText: "Find your city",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 24.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 18.h),
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                        context.read<SearchCubit>().resetSearch();
                      },
                      icon: Icon(Icons.close, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, searchState) {
                  if (searchState is InitialSearch ||
                      searchState is SearchLoading) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.my_location,
                                color: Colors.blue.shade700,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),

                              Text(
                                "Use my current location",
                                style: TextStyle(
                                  color: AppTheme.secondaryDarkBlue,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          "RECENT",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: AppTheme.primaryDarkBlue,
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    );
                  } else if (searchState is SearchError) {
                    return Center(
                      child: Column(
                        children: [
                          Icon(Icons.search_off_sharp, size: 28.sp),
                          SizedBox(height: 8.h),
                          Text(
                            searchState.errorMessage,
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ],
                      ),
                    );
                  } else if (searchState is SearchLoaded) {
                    if (searchState.results.isNotEmpty) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchState.results.length,
                        itemBuilder: (context, index) {
                          final cityName = searchState.results[index].name
                              .toString();
                          final countryCode = searchState.results[index].country
                              .toString();
                          final country = CountryService().findByCode(
                            countryCode,
                          );
                          final fullCountryName = country?.name ?? countryCode;
                          final flagEmoji = country?.flagEmoji ?? '📍';

                          return ListTile(
                            onTap: () {},
                            leading: Text(
                              flagEmoji,
                              style: TextStyle(fontSize: 28.sp),
                            ),
                            title: Text(cityName),
                            subtitle: Text(fullCountryName),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 150.h),
                            Icon(
                              Icons.search_off_outlined,
                              size: 80.sp,
                              color: Colors.grey,
                            ),
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
                    }
                  }
                  return SizedBox();
                },
              ),

              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }
}
