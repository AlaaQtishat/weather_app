import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';

class RainAlertCard extends StatelessWidget {
  final double rainValue;
  const RainAlertCard({super.key, required this.rainValue});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          isDark
              ? BoxShadow(color: Colors.transparent)
              : BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
        ],
        border: isDark ? Border.all(color: Colors.white24) : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Row(
          children: [
            Icon(Icons.umbrella, color: Colors.purpleAccent, size: 28.w),
            SizedBox(width: 12.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 13.sp),
                  children: [
                    TextSpan(
                      text: "Grab an umbrella. ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppTheme.primaryDarkBlue,
                      ),
                    ),
                    TextSpan(
                      text:
                          "Rain expected through the afternoon — $rainValue mm in the last hour.",
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
