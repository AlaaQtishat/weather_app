import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFD4E3FB), width: 1.5.w),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatColumn(value: "12", label: "CITIES"),
          ),
          VerticalDivider(
            color: const Color(0xFFD4E3FB),
            thickness: 1.5.w,
            width: 1,
          ),
          Expanded(
            child: _buildStatColumn(value: "347", label: "CHECKS"),
          ),
          VerticalDivider(
            color: const Color(0xFFD4E3FB),
            thickness: 1.5.w,
            width: 1,
          ),
          Expanded(
            child: _buildStatColumn(value: "8", label: "ALERTS"),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn({required String value, required String label}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F243E),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF7B8BA4),
          ),
        ),
      ],
    );
  }
}
