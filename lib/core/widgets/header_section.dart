import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/widgets/letter_widget.dart';
import 'package:weather_app/features/location/cubit/location_cubit.dart';
import 'package:weather_app/features/location/cubit/location_state.dart';
import 'package:weather_app/features/main_layout/cubit/navigation_cubit.dart';
import 'package:weather_app/features/user/cubit/user_cubit.dart';
import 'package:weather_app/features/user/cubit/user_state.dart';

class HeaderSection extends StatefulWidget {
  final bool isHome;
  final bool showCloseButton;
  final String? cityName;
  HeaderSection({
    super.key,
    required this.isHome,
    this.showCloseButton = false,
    this.cityName,
  });

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
    if (widget.cityName != null) {
      displayCity = widget.cityName!;
    } else {
      if (locationState is LocationLoaded) {
        displayCity = locationState.cityName;
      } else if (locationState is LocationLoading ||
          locationState is LocationInitial) {
        displayCity = "Loading...";
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.showCloseButton) ...[
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close, color: Colors.grey, size: 28.sp),
                ),
                //  SizedBox(width: 8.w),
              ],

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (!widget.isHome) ...[
                          Icon(Icons.pin_drop_outlined, size: 14.sp),
                          SizedBox(width: 4.w),
                        ],
                        Flexible(
                          child: Text(
                            widget.isHome ? formattedDate : displayCity,
                            style: TextStyle(fontSize: 14.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        if (widget.isHome) ...[
                          Icon(Icons.my_location_outlined, size: 16.sp),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: Text(
                              displayCity,
                              style: TextStyle(
                                fontSize: displayCity.length <= 10
                                    ? 28.sp
                                    : displayCity.length <= 15
                                    ? 24.sp
                                    : displayCity.length <= 21
                                    ? 22.sp
                                    : 16.sp,
                                fontWeight: FontWeight.bold,
                                color: (displayCity == "Unknown Location")
                                    ? Colors.redAccent
                                    : null,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ] else ...[
                          Flexible(
                            child: Text(
                              "10-Day Forecast",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 12.w),

        if (userState is UserLoaded)
          if (!widget.showCloseButton)
            GestureDetector(
              child: LetterWidget(letter: userState.user.fname[0]),
              onTap: () {
                context.read<NavigationCubit>().changeIndex(3);
              },
            )
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
      ],
    );
  }
}
