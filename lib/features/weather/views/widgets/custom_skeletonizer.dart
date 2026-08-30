import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomSkeletonizer extends StatelessWidget {
  final Widget child;
  const CustomSkeletonizer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: isDark ? const Color(0xFF2A2E4A) : Colors.grey.shade300,
        highlightColor: isDark ? const Color(0xFF3A3F5F) : Colors.grey.shade100,
      ),
      enabled: true,
      child: child,
    );
  }
}
