import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/network/dio_helper.dart';
import 'package:weather_app/core/theme/cubit/theme_cubit.dart';
import 'package:weather_app/core/theme/cubit/theme_state.dart';
import 'package:weather_app/features/auth/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/services/auth_service.dart';
import 'package:weather_app/features/auth/services/remember_me_prefs.dart';
import 'package:weather_app/features/location/cubit/location_cubit.dart';
import 'package:weather_app/features/search/cubit/recents_cubit.dart';
import 'package:weather_app/features/search/cubit/search_cubit.dart';
import 'package:weather_app/features/user/cubit/user_cubit.dart';
import 'package:weather_app/features/user/services/user_service.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/firebase_options.dart';
import 'package:weather_app/features/onboarding/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize();
  final AuthService authService = AuthService();
  final RememberMePrefs prefs = RememberMePrefs();
  final UserService userService = UserService();
  DioHelper.init();
  runApp(
    MyApp(authService: authService, prefs: prefs, userService: userService),
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.authService,
    required this.prefs,
    required this.userService,
  });
  final AuthService authService;
  final UserService userService;
  final RememberMePrefs prefs;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit(authService, prefs)),
            BlocProvider(create: (context) => UserCubit(userService)),
            BlocProvider(create: (context) => LocationCubit()),
            BlocProvider(create: (context) => WeatherCubit()),
            BlocProvider(create: (context) => SearchCubit()),
            BlocProvider(create: (context) => RecentsCubit()),
            BlocProvider(create: (context) => ThemeCubit()),
          ],

          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                home: SplashScreen(),
                debugShowCheckedModeBanner: false,

                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState.themeMode,
              );
            },
          ),
        );
      },
    );
  }
}
