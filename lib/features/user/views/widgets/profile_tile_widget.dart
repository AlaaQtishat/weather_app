import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTileWidget extends StatelessWidget {
  final String img;
  final String title;
  final Widget trailingWidget;

  const ProfileTileWidget({
    super.key,
    required this.img,
    required this.title,
    required this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black38.withOpacity(0.08),
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
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          trailingWidget,
        ],
      ),
    );
  }
}
