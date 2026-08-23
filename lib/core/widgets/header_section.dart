import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
    context.read<LocationCubit>().fetchUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(now);
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
                    ? SizedBox()
                    : Icon(
                        Icons.pin_drop_outlined,
                        color: AppTheme.secondaryDarkBlue,
                        size: 14.sp,
                      ),
                widget.isHome ? SizedBox() : SizedBox(width: 4.w),

                Text(
                  widget.isHome ? formattedDate : "Province of Turin",
                  style: TextStyle(
                    color: AppTheme.secondaryDarkBlue,
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
                        color: Colors.grey,
                      )
                    : SizedBox(),
                widget.isHome ? SizedBox(width: 4.w) : SizedBox(),
                BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, state) {
                    if (state is LocationLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is LocationLoaded) {
                      return Text(
                        widget.isHome ? "${state.cityName}" : "7-Day Forecast",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: AppTheme.primaryDarkBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else if (state is LocationError) {
                      return Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
          ],
        ),
        BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            if (userState is UserLoaded) {
              final user = userState.user;
              return Column(
                children: [LetterWidget(letter: user.fname[0].toUpperCase())],
              );
            } else if (userState is UserError) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Text(userState.errorMessage),
              );
            } else if (userState is UserLoading) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: const CircularProgressIndicator(),
              );
            }
            return SizedBox(height: 40.h);
          },
        ),
      ],
    );
  }
}
