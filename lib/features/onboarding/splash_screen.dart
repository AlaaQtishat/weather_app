import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/onboarding/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
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
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }
}
