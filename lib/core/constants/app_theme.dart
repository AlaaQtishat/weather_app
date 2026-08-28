import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static final Color lightSelected = Color(0xFF2D3561);
  static final Color lightUnselected = Color(0xFFB5BBC9);
  static final Color darkUnselected = Colors.grey;
  static final Color darkSelected = Colors.white;
  static final Color primaryBlue = Color(0xFF2A6AE8);
  static final Color primaryDarkBlue = Color(0xFF1F243E);
  static final Color secondaryDarkBlue = Color(0xFF2B4368);
  static final Color primaryLightBlue = Color(0xFF7AB3E0);
  static final RadialGradient lightScaffoldGradient = RadialGradient(
    center: Alignment.topRight,
    radius: 1.0,
    colors: [Color(0xFF5A98FC), Color(0xFFEEF3FB)],
  );

  static const LinearGradient darkScaffoldGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFF2D68FF), Color(0xFF1A1E3A), Color(0xFF1A1E3A)],
    stops: [0.0, 0.30, 1.0],
  );
  static const lightLetterWidget = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5A80D8), Color(0xFF293865)],
  );
  static const darkLetterWidget = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7AB3E0), Color(0xFFA88ADB)],
  );
  static final lightTheme = ThemeData(
    iconTheme: IconThemeData(color: secondaryDarkBlue),
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
      bodyLarge: TextStyle(color: Color(0xFF1F243E)),
      bodySmall: TextStyle(color: Color(0xFF1F243E)),
      bodyMedium: TextStyle(color: Color(0xFF1F243E)),
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
      bodyLarge: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    cardColor: Colors.white.withOpacity(0.15),

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
    //     foregroundColor: Colors.grey,
    //     backgroundColor: Color(0xFF1C1C1E),
    //     side: BorderSide(color: Colors.grey, width: 0.3),
    //   ),
    // ),
  );
}
