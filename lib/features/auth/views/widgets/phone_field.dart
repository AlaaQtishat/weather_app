import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:weather_app/core/constants/app_theme.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  PhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IntlPhoneField(
      controller: controller,
      pickerDialogStyle: PickerDialogStyle(
        backgroundColor: theme.cardColor,
        countryNameStyle: TextStyle(color: Colors.black87, fontSize: 16.sp),
        countryCodeStyle: TextStyle(color: Colors.black54, fontSize: 16.sp),
        searchFieldCursorColor: AppTheme.primaryBlue,
        searchFieldInputDecoration: InputDecoration(
          hintText: "Search for countries",
          hintStyle: TextStyle(color: Colors.black45),
          filled: true,
          fillColor: Colors.transparent,
          prefixIcon: Icon(Icons.search, color: Colors.black45),

          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
          ),

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2.w),
          ),
        ),
      ),
      cursorColor: Colors.grey,
      flagsButtonPadding: EdgeInsets.symmetric(horizontal: 12.w),
      showDropdownIcon: true,
      dropdownIconPosition: IconPosition.trailing,
      dropdownIcon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Colors.grey.shade600,
      ),
      decoration: InputDecoration(
        counterText: "",
        filled: true,
        fillColor: Colors.white,
        hintText: "phone number",
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16.sp),
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppTheme.primaryBlue),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      initialCountryCode: 'JO',
      onChanged: (phone) {
        print(phone.completeNumber);
      },
    );
  }
}
