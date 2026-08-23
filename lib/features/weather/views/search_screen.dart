import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/widgets/container_background.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
                  ),
                ),
              ),
              SizedBox(height: 16.h),

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
              SizedBox(height: 40.h),
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

              _buildRecentCityCard(
                "Rome",
                "Italy · Lazio",
                "19°",
                "Partly Cloudy",
              ),
              _buildRecentCityCard("London", "United Kingdom", "14°", "Rainy"),
              _buildRecentCityCard("Tokyo", "Japan", "28°", "Mostly Clear"),
              _buildRecentCityCard(
                "Dubai",
                "United Arab Emirates",
                "38°",
                "Sunny",
              ),
              _buildRecentCityCard(
                "New York",
                "United States",
                "22°",
                "Cloudy",
              ),

              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentCityCard(
    String city,
    String country,
    String temp,
    String condition,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Row(
        children: [
          Container(
            height: 55.h,
            width: 55.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(Icons.location_city, color: Colors.grey, size: 24.sp),
          ),

          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryDarkBlue,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  country,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                temp,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.primaryDarkBlue,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                condition,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
