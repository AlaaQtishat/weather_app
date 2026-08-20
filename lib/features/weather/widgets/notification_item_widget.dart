import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';

class NotificationItemWidget extends StatelessWidget {
  final String img;
  final Color imgBgColor;
  final String title;
  final bool switchValue;
  final ValueChanged<bool>? onChanged;

  const NotificationItemWidget({
    super.key,
    required this.img,
    required this.imgBgColor,
    required this.title,
    required this.switchValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 36.r,
            height: 36.r,
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
          CupertinoSwitch(
            value: switchValue,
            activeColor: const Color(0xFF8DA4F6),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
