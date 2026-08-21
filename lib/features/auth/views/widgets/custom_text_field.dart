import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final bool isPassword;
  final bool isCalender;
  final bool isPhoneNumber;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String hint;
  final String countryFlag;
  final String countryDialCode;
  final VoidCallback? onCountryTap;
  VoidCallback? onTap;

  CustomTextField({
    required this.validator,
    super.key,
    required this.hint,
    this.isPassword = false,
    this.isCalender = false,
    this.isPhoneNumber = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.onTap,
    this.countryFlag = '🇯🇴',
    this.countryDialCode = '+962',
    this.onCountryTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: widget.controller,
      readOnly: widget.isCalender ? true : false,
      onTap: widget.onTap,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red.shade100),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red.shade900),
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
            ? Icon(
                Icons.calendar_today_outlined,
                color: Colors.grey,
                size: 24.sp,
              )
            : null,
        prefixIcon: widget.isPhoneNumber
            ? InkWell(
                onTap: widget.onCountryTap,
                borderRadius: BorderRadius.circular(12.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.countryFlag!,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        widget.countryDialCode!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
                      SizedBox(width: 4.w),

                      Container(
                        height: 24.h,
                        width: 1.w,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(width: 8.w),
                    ],
                  ),
                ),
              )
            : null,
      ),
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
    );
  }
}
