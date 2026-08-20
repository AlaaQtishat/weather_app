import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/widgets/custom_elevated_button.dart';
import 'package:weather_app/features/auth/views/sign_in.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppTheme.scaffoldGradient),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Image.asset(
                "assets/images/welcome_img.png",
                height: 120,
                width: 120,
              ),
              SizedBox(height: 4),
              Text(
                "Welcome!",
                style: TextStyle(
                  fontSize: 40.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Precise weather, beautifully presented.",
                style: TextStyle(fontSize: 16.sp, color: Colors.black54),
              ),
              SizedBox(height: 48.h),
              CustomElevatedButton(
                content: Text("Get Started"),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => SignIn()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
