import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/features/user/views/widgets/logout_tile_widget.dart';
import 'package:weather_app/features/user/views/widgets/profile_card_widget.dart';
import 'package:weather_app/features/user/views/widgets/profile_header_widget.dart';
import 'package:weather_app/features/user/views/widgets/temperature_tile_widget.dart';
import 'package:weather_app/features/user/views/widgets/theme_tile_widget.dart';
import 'package:weather_app/features/user/views/widgets/time_format_tile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerBackground(
        content: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 80.h),
                const ProfileHeader(),
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "PREFERENCES",
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                ProfileCardWidget(
                  items: const [
                    TemperatureTileWidget(),
                    TimeFormatTileWidget(),
                  ],
                ),
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "SETTINGS",
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                ProfileCardWidget(
                  items: const [ThemeTileWidget(), LogoutTileWidget()],
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
