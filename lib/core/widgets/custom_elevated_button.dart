import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget content;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  const CustomElevatedButton({
    super.key,
    required this.content,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          fixedSize: Size(double.infinity, 60.h),
        ),
        child: content,
      ),
    );
  }
}
