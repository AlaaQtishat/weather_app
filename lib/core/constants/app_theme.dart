import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static final Color lightSelected = Color(0xFF2D3561);
  static final Color lightUnselected = Color(0xFFB5BBC9);
  static final Color darkUnselected = Colors.grey;
  static final Color darkSelected = Colors.white;
  static final Color primaryBlue = Color(0xFF2A6AE8);
  static final Color primaryDarkBlue = Color(0xFF1F243E);
  static final Color secondaryDarkBlue = Color(0xFF3A5A8A);
  static final RadialGradient scaffoldGradient = RadialGradient(
    center: Alignment.topRight,
    radius: 1.0,
    colors: [
      Color(0xFF93BBFB),
      HSLColor.fromAHSL(1.0, 217, 0.62, 0.96).toColor(),
    ],
  );
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.transparent,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
        foregroundColor: Colors.black45,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1D293D)),
      bodySmall: TextStyle(color: Color(0xFF1D293D)),
      bodyMedium: TextStyle(color: Color(0xFF1D293D)),
    ),
    cardColor: Colors.white,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16.sp),
        backgroundColor: Color(0xFF2A6AE8),
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    ),
    // iconButtonTheme: IconButtonThemeData(
    //   style: IconButton.styleFrom(
    //     foregroundColor: Colors.white,
    //     backgroundColor: Color(0xFF2A6AE8),
    //     side: BorderSide(color: Colors.transparent),
    //   ),
    // ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF09090B),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
        foregroundColor: Colors.white70,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white70),
      bodySmall: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    cardColor: Color(0xFF2A2E48),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF171717),
        //   foregroundColor: darkGrey,
      ),
    ),
    // iconButtonTheme: IconButtonThemeData(
    //   style: IconButton.styleFrom(
    //     foregroundColor: Colors.grey,
    //     backgroundColor: Color(0xFF1C1C1E),
    //     side: BorderSide(color: Colors.grey, width: 0.3),
    //   ),
    // ),
  );
}
