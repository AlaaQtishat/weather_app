import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/auth/views/sign_in.dart';
import 'package:weather_app/features/location/cubit/location_cubit.dart';
import 'package:weather_app/features/onboarding/services/seen_prefs.dart';
import 'package:weather_app/features/onboarding/views/welcome_screen.dart';
import 'package:weather_app/features/user/cubit/user_cubit.dart';
import 'package:weather_app/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/views/main_layout_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  SeenPrefs seen = SeenPrefs();
  late bool? isSeen;
  @override
  void initState() {
    super.initState();
    if (user != null) {
      context.read<UserCubit>().fetchUserData(user!.uid);
    }
    context.read<LocationCubit>().fetchUserLocation();
    context.read<WeatherCubit>().fetchWeatherData();
    navigateBasedOnAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.scaffoldGradient),
        child: Center(
          child: Image.asset(
            "assets/images/welcome_img.png",
            height: 180,
            width: 180,
          ),
        ),
      ),
    );
  }

  void navigateBasedOnAuth() async {
    Future.delayed(const Duration(seconds: 3), () async {
      isSeen = await seen.getIsSeen();
      if (!mounted) return;
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainLayoutScreen()),
        );
      } else {
        if (isSeen == true) {
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        }
      }
    });
  }
}
