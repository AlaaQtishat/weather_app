import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';

class PreferenceItemWidget extends StatelessWidget {
  final String img;
  final Color imgBgColor;
  final String title;
  final String trailingText;

  const PreferenceItemWidget({
    super.key,
    required this.img,
    required this.imgBgColor,
    required this.title,
    required this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: imgBgColor,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              img,
              width: 24.w,
              height: 24.h,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: AppTheme.primaryDarkBlue,
            ),
          ),
          const Spacer(),
          Text(
            trailingText,
            style: TextStyle(fontSize: 14.sp, color: const Color(0xFF7B8BA4)),
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.arrow_forward_ios,
            size: 14.sp,
            color: const Color(0xFF7B8BA4),
          ),
        ],
      ),
    );
  }
}
