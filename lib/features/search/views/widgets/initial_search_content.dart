import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/search/views/widgets/current_location_button.dart';

class InitialSearchContent extends StatelessWidget {
  final TextEditingController searchController;
  const InitialSearchContent({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CurrentLocationButton(searchController: searchController),
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
  }
}
