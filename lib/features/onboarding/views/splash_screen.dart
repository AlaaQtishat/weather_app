import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/app%20preferences/app_preferences_service.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/features/auth/views/sign_in.dart';
import 'package:weather_app/features/location/cubit/location_cubit.dart';

import 'package:weather_app/features/onboarding/views/welcome_screen.dart';
import 'package:weather_app/features/main_layout/views/main_layout_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  AppPreferences prefs = AppPreferences();
  late bool? isSeen;
  @override
  void initState() {
    super.initState();
    context.read<LocationCubit>().fetchUserLocation();
    navigateBasedOnAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerBackground(
        content: Center(
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
      isSeen = await prefs.getIsSeen();
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
