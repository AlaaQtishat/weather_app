import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';

class LetterWidget extends StatelessWidget {
  final String letter;
  final bool isProfileScreen;
  const LetterWidget({
    super.key,
    required this.letter,
    this.isProfileScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: isProfileScreen ? 170.r : 60.r,
      height: isProfileScreen ? 170.r : 60.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isDark
            ? AppTheme.darkLetterWidget
            : AppTheme.lightLetterWidget,
        border: isDark
            ? Border()
            : Border.all(color: const Color(0xFF4A68B0), width: 3.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        letter.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: isProfileScreen ? 90.sp : 24.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
