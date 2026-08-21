import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/auth/controllers/auth_controller.dart';
import 'package:weather_app/features/auth/controllers/cubit/auth_cubit.dart';
import 'package:weather_app/firebase_options.dart';
import 'package:weather_app/features/onboarding/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final AuthController authController = AuthController();
  runApp(MyApp(authController: authController));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.authController});
  final AuthController authController;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => AuthCubit(authController),
          child: MaterialApp(
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
          ),
        );
      },
    );
  }
}
