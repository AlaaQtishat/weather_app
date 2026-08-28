import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/utils/debouncer.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/features/search/cubit/search_cubit.dart';
import 'package:weather_app/features/search/cubit/search_state.dart';
import 'package:weather_app/features/search/views/widgets/initial_search_content.dart';
import 'package:weather_app/features/search/views/widgets/search_bar_widget.dart';
import 'package:weather_app/features/search/views/widgets/search_results_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: ContainerBackground(
          content: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchHeaderTitle(),
                SizedBox(height: 32.h),

                SearchBarWidget(
                  controller: searchController,
                  debouncer: _debouncer,
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
                      return SearchErrorWidget(
                        errorMessage: searchState.errorMessage,
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

class SearchHeaderTitle extends StatelessWidget {
  const SearchHeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
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
            color: isDark ? Colors.white70 : AppTheme.primaryDarkBlue,
          ),
        ),
      ],
    );
  }
}

class SearchErrorWidget extends StatelessWidget {
  final String errorMessage;

  const SearchErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 100.h),
          Icon(Icons.search_off_sharp, size: 40.sp, color: Colors.redAccent),
          SizedBox(height: 8.h),
          Text(
            textAlign: TextAlign.center,
            errorMessage,
            style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
