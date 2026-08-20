import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/auth/controllers/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/controllers/cubit/auth_state.dart';
import 'package:weather_app/features/auth/views/sign_in.dart';
import 'package:weather_app/features/weather/widgets/letter_widget.dart';
import 'package:weather_app/features/weather/widgets/notification_item_widget.dart';
import 'package:weather_app/features/weather/widgets/preference_item_widget.dart';
import 'package:weather_app/features/weather/widgets/profile_card_widget.dart';
import 'package:weather_app/features/weather/widgets/stats_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppTheme.scaffoldGradient),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 80.h),
                const LetterWidget(),
                SizedBox(height: 14.h),
                Text(
                  "Alaa Qtishat",
                  style: TextStyle(
                    color: AppTheme.primaryDarkBlue,
                    fontWeight: FontWeight.w800,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "alaaqtishat2004@gmail.com",
                  style: TextStyle(
                    color: const Color(0xFF7B8BA4),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 24.h),

                StatsWidget(),

                SizedBox(height: 32.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "PREFERENCES",
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      color: AppTheme.primaryDarkBlue,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                ProfileCardWidget(
                  items: [
                    PreferenceItemWidget(
                      img: "assets/images/temperature.png",
                      imgBgColor: const Color(0xFFFDECEE),
                      title: "Temperature",
                      trailingText: "Celsius",
                    ),
                    PreferenceItemWidget(
                      img: "assets/images/wind.png",
                      imgBgColor: const Color(0xFFE3F0FC),
                      title: "Wind Speed",
                      trailingText: "m/s",
                    ),
                    PreferenceItemWidget(
                      img: "assets/images/time.png",
                      imgBgColor: const Color(0xFFF1F4F9),
                      title: "Time Format",
                      trailingText: "24h",
                    ),
                    PreferenceItemWidget(
                      img: "assets/images/pin.png",
                      imgBgColor: const Color(0xFFFDECEE),
                      title: "Home Location",
                      trailingText: "Turin, IT",
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "NOTIFICATIONS",
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      color: AppTheme.primaryDarkBlue,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                ProfileCardWidget(
                  items: [
                    NotificationItemWidget(
                      img: "assets/images/severse.png",
                      imgBgColor: const Color(0xFFFFF4E5),
                      title: "Severe Alerts",
                      switchValue: true,
                    ),
                    NotificationItemWidget(
                      img: "assets/images/rain.png",
                      imgBgColor: const Color(0xFFE3F0FC),
                      title: "Daily Forecast",
                      switchValue: true,
                    ),
                    NotificationItemWidget(
                      img: "assets/images/sun.png",
                      imgBgColor: const Color(0xFFFFF9E6),
                      title: "Morning Summary",
                      switchValue: false,
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (ModalRoute.of(context)?.isCurrent != true) return;
                    if (state is AuthSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("signed out successfully!"),
                        ),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        if (state is AuthLoading) {
                          return;
                        }
                        context.read<AuthCubit>().logoutCubit();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCECEE),
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(
                            color: const Color(0xFFF5D6DA),
                            width: 1.w,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: state is AuthLoading
                            ? CircularProgressIndicator()
                            : Text(
                                "Sign Out",
                                style: TextStyle(
                                  color: const Color(0xFFE57373),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
