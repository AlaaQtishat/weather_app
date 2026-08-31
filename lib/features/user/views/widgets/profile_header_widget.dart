import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/widgets/letter_widget.dart';
import 'package:weather_app/features/user/cubit/user_cubit.dart';
import 'package:weather_app/features/user/cubit/user_state.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          final user = userState.user;
          return Column(
            children: [
              LetterWidget(letter: user.fname[0], isProfileScreen: true),
              SizedBox(height: 14.h),
              Text(
                "${user.fname} ${user.lname}",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 32.sp),
              ),
              SizedBox(height: 2.h),
              Text(
                user.email,
                style: TextStyle(
                  color: isDark ? Colors.white70 : AppTheme.secondaryDarkBlue,
                  fontSize: 16.sp,
                ),
              ),
            ],
          );
        } else if (userState is UserError) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Text(userState.errorMessage),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: CircularProgressIndicator(color: AppTheme.primaryBlue),
        );
      },
    );
  }
}
