import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/app%20preferences/cubit/preferences_cubit.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/user/views/widgets/profile_tile_widget.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/cubit/weather_state.dart';

class TemperatureTileWidget extends StatelessWidget {
  const TemperatureTileWidget();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tempUnit = context.select((PreferencesCubit c) => c.state.tempUnit);

    return ProfileTileWidget(
      img: "assets/images/temperature.png",
      title: "Temperature",
      trailingWidget: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, weatherState) {
          final bool isReady = weatherState is WeatherLoaded;

          return DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: isDark ? AppTheme.primaryDarkBlue : Colors.white,
              value: tempUnit,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
              alignment: Alignment.centerRight,
              items: [
                DropdownMenuItem(
                  value: 'metric',
                  child: Text("Celsius", style: TextStyle(fontSize: 14.sp)),
                ),
                DropdownMenuItem(
                  value: 'imperial',
                  child: Text("Fahrenheit", style: TextStyle(fontSize: 14.sp)),
                ),
              ],

              onChanged: isReady
                  ? (String? newValue) {
                      if (newValue != null && newValue != tempUnit) {
                        context.read<PreferencesCubit>().changeTempUnit(
                          newValue,
                        );

                        final double lat = weatherState.current.lat ?? 0.0;
                        final double lon = weatherState.current.lon ?? 0.0;
                        context.read<WeatherCubit>().fetchWeatherData(lat, lon);
                      }
                    }
                  : null,
            ),
          );
        },
      ),
    );
  }
}
