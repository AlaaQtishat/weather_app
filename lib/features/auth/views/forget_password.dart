import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/auth/views/widgets/custom_text_field.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(gradient: AppTheme.scaffoldGradient),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    Align(
                      alignment: AlignmentGeometry.topLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.keyboard_backspace_rounded),
                      ),
                    ),
                    SizedBox(height: 150.h),
                    Image.asset(
                      "assets/images/sad_cloud.png",
                      height: 200.h,
                      width: 200.w,
                    ),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      textAlign: TextAlign.center,
                      "Don't worry! It happens. Please enter your email address to receive a reset link.",
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(hint: "Email", controller: emailController),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
