import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:weather_app/core/constants/app_theme.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String completeNumber, String countryCode)? onChanged;
  final String? errorText;

  const PhoneField({
    super.key,
    required this.controller,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntlPhoneField(
          controller: controller,

          initialCountryCode: 'JO',

          pickerDialogStyle: PickerDialogStyle(
            backgroundColor: theme.cardColor,
            countryNameStyle: TextStyle(color: Colors.black87, fontSize: 16.sp),
            countryCodeStyle: TextStyle(color: Colors.black54, fontSize: 16.sp),
            searchFieldCursorColor: AppTheme.primaryBlue,
            searchFieldInputDecoration: InputDecoration(
              hintText: "Search for countries",
              hintStyle: const TextStyle(color: Colors.black45),
              filled: true,
              fillColor: Colors.transparent,
              prefixIcon: const Icon(Icons.search, color: Colors.black45),
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

            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 12.w,
            ),

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: hasError ? Colors.red : Colors.grey.shade100,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: hasError ? Colors.red : AppTheme.primaryBlue,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),

            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.red.shade100),
              borderRadius: BorderRadius.circular(12.r),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.red),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),

          onChanged: (phone) {
            onChanged?.call(phone.completeNumber, phone.countryISOCode);
          },
        ),

        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(left: 12.w, top: 6.h),
            child: Text(
              "  " + errorText!,
              style: TextStyle(color: Colors.red.shade800, fontSize: 13.sp),
            ),
          ),
      ],
    );
  }
}
