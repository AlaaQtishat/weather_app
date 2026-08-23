import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/app_theme.dart';

class ContainerBackground extends StatelessWidget {
  Widget content;
  ContainerBackground({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(gradient: AppTheme.scaffoldGradient),
      child: content,
    );
  }
}
