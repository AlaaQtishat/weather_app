import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final bool isPassword;
  final bool isCalender;
  final bool isPhoneNumber;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String hint;
  VoidCallback? onTap;
  CustomTextField({
    super.key,
    required this.hint,
    this.isPassword = false,
    this.isCalender = false,
    this.isPhoneNumber = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.onTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

bool _obscureText = true;

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: widget.controller,
      readOnly: widget.isCalender ? true : false,
      onTap: widget.onTap,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        hint: Text(
          widget.hint,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        filled: true,
        fillColor: theme.cardColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppTheme.primaryBlue),
          borderRadius: BorderRadius.circular(12.r),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  size: 24.sp,
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.isCalender
            ? IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                  size: 24.sp,
                ),
              )
            : null,
        prefixIcon: widget.isPhoneNumber
            ? Icon(Icons.outlined_flag, color: Colors.grey, size: 24.sp)
            : null,
      ),
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
    );
  }
}
