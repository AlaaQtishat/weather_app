import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LetterWidget extends StatelessWidget {
  final String letter;
  const LetterWidget({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.r,
      height: 120.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5A80D8), Color(0xFF293865)],
        ),
        border: Border.all(color: const Color(0xFF4A68B0), width: 3.w),
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
          fontSize: 55.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
