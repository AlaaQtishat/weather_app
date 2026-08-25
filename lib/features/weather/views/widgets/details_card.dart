import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';

class DetailsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final String measurement;
  const DetailsCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.measurement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w900,
              color: AppTheme.secondaryDarkBlue,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryDarkBlue,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                measurement,
                style: TextStyle(fontSize: 20.sp, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppTheme.secondaryDarkBlue,
            ),
          ),
        ],
      ),
    );
  }
}
