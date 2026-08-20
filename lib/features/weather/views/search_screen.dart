import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/app_theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppTheme.scaffoldGradient),
      ),
    );
  }
}
