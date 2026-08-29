import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/widgets/letter_widget.dart';
import 'package:weather_app/features/location/cubit/location_cubit.dart';
import 'package:weather_app/features/location/cubit/location_state.dart';
import 'package:weather_app/features/user/cubit/user_cubit.dart';
import 'package:weather_app/features/user/cubit/user_state.dart';

class HeaderSection extends StatefulWidget {
  final bool isHome;
  HeaderSection({super.key, required this.isHome});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  final DateTime now = DateTime.now();
  @override
  void initState() {
    super.initState();
    final userCubit = context.read<UserCubit>();
    if (userCubit.state is UserInitial) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        userCubit.fetchUserData(currentUser.uid);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(now);
    final locationState = context.watch<LocationCubit>().state;
    final userState = context.watch<UserCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String displayCity = "Unknown Location";
    if (locationState is LocationLoaded) {
      displayCity = locationState.cityName;
    } else if (locationState is LocationLoading ||
        locationState is LocationInitial) {
      displayCity = "Loading...";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                widget.isHome
                    ? const SizedBox()
                    : Icon(
                        Icons.pin_drop_outlined,
                        // color: AppTheme.secondaryDarkBlue,
                        size: 14.sp,
                      ),
                widget.isHome ? const SizedBox() : SizedBox(width: 4.w),
                Text(
                  widget.isHome ? formattedDate : displayCity,
                  style: TextStyle(
                    //  color: AppTheme.secondaryDarkBlue,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                widget.isHome
                    ? Icon(
                        Icons.my_location_outlined,
                        size: 16.sp,
                        //    color: Colors.grey,
                      )
                    : const SizedBox(),
                widget.isHome ? SizedBox(width: 4.w) : const SizedBox(),

                if (widget.isHome)
                  if (locationState is LocationLoading ||
                      locationState is LocationInitial)
                    Skeletonizer(
                      containersColor: isDark
                          ? Colors.white.withOpacity(0.06)
                          : AppTheme.primaryDarkBlue.withOpacity(0.12),
                      child: Text(
                        "Loading City",
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else if (locationState is LocationLoaded)
                    Text(
                      locationState.cityName,
                      style: TextStyle(
                        fontSize: locationState.cityName.length <= 10
                            ? 28.sp
                            : locationState.cityName.length <= 15
                            ? 24.sp
                            : locationState.cityName.length <= 21
                            ? 22.sp
                            : 12.sp,
                        //  color: AppTheme.primaryDarkBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else
                    Text(
                      "Location Unknown",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                else
                  Text(
                    "7-Day Forecast",
                    style: TextStyle(
                      fontSize: 22.sp,
                      //      color: AppTheme.primaryDarkBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ],
        ),

        if (userState is UserLoaded)
          LetterWidget(letter: userState.user.fname[0].toUpperCase())
        else if (userState is UserError)
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.shade50,
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Center(
              child: Icon(
                Icons.person_off_outlined,
                color: Colors.redAccent,
                size: 20.sp,
              ),
            ),
          ),
        // else
        //   Skeletonizer(
        //
        //     child: const LetterWidget(letter: "A"),
        //   ),
      ],
    );
  }
}
