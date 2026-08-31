import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/app%20preferences/cubit/preferences_cubit.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/user/views/widgets/profile_tile_widget.dart';

class TimeFormatTileWidget extends StatelessWidget {
  const TimeFormatTileWidget();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final timeFormat = context.select(
      (PreferencesCubit c) => c.state.timeFormat,
    );

    return ProfileTileWidget(
      img: "assets/images/time.png",
      title: "Time Format",
      trailingWidget: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: isDark ? AppTheme.primaryDarkBlue : Colors.white,
          value: timeFormat,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          alignment: Alignment.centerRight,
          items: [
            DropdownMenuItem(
              value: '24h',
              child: Text("24 Hour", style: TextStyle(fontSize: 14.sp)),
            ),
            DropdownMenuItem(
              value: '12h',
              child: Text("12 Hour", style: TextStyle(fontSize: 14.sp)),
            ),
          ],
          onChanged: (String? newValue) {
            if (newValue != null && newValue != timeFormat) {
              context.read<PreferencesCubit>().changeTimeFormat(newValue);
            }
          },
        ),
      ),
    );
  }
}
