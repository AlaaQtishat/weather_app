import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/utils/debouncer.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/features/search/cubit/search_cubit.dart';
import 'package:weather_app/features/search/cubit/search_state.dart';
import 'package:weather_app/features/search/views/widgets/initial_search_content.dart';
import 'package:weather_app/features/search/views/widgets/search_results_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final Debouncer debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    searchController.dispose();
    debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: ContainerBackground(
          content: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Find a city.",
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,

                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "Search anywhere in the world",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: isDark
                            ? Colors.white70
                            : AppTheme.primaryDarkBlue,
                      ),
                    ),
                  ],
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
                        debouncer.dispose();
                        context.read<SearchCubit>().resetSearch();
                        return;
                      }
                      debouncer.run(() {
                        context.read<SearchCubit>().getSearchResult(value);
                      });
                    },
                    onSubmitted: (_) => FocusScope.of(context).unfocus(),
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
                        icon: const Icon(Icons.close, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, searchState) {
                    if (searchState is InitialSearch ||
                        searchState is SearchLoading) {
                      return InitialSearchContent(
                        searchController: searchController,
                      );
                    } else if (searchState is SearchError) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(height: 100.h),
                            Icon(
                              Icons.search_off_sharp,
                              size: 40.sp,
                              color: Colors.redAccent,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              textAlign: TextAlign.center,
                              searchState.errorMessage,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (searchState is SearchLoaded) {
                      return SearchResultsList(
                        results: searchState.results,
                        searchController: searchController,
                      );
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
