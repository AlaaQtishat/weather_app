import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/app%20preferences/cubit/preferences_cubit.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/user/views/widgets/profile_tile_widget.dart';

class ThemeTileWidget extends StatelessWidget {
  const ThemeTileWidget();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDarkMode = context.select(
      (PreferencesCubit c) => c.state.isDarkMode,
    );

    return ProfileTileWidget(
      img: isDark
          ? "assets/images/darktheme.png"
          : "assets/images/lighttheme.png",
      title: "Theme",
      trailingWidget: Switch(
        value: isDarkMode,
        activeColor: isDark ? AppTheme.primaryLightBlue : AppTheme.primaryBlue,
        onChanged: (newValue) {
          context.read<PreferencesCubit>().toggleTheme(newValue);
        },
      ),
    );
  }
}
