import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCardWidget extends StatelessWidget {
  final List<Widget> items;

  const ProfileCardWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < items.length; i++) {
      children.add(items[i]);
      if (i < items.length - 1) {
        children.add(
          Divider(
            height: 1,
            thickness: 1,
            color: const Color(0xFFE3ECFB),
            indent: 64.w,
          ),
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFD4E3FB), width: 1.w),
      ),
      child: Column(children: children),
    );
  }
}
