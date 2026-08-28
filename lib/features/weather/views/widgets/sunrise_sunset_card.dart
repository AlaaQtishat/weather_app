import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'dart:async';

import 'package:weather_app/core/constants/app_theme.dart';

class SunriseSunsetCard extends StatefulWidget {
  final int sunriseTimestamp;
  final int sunsetTimestamp;

  const SunriseSunsetCard({
    super.key,
    required this.sunriseTimestamp,
    required this.sunsetTimestamp,
  });

  @override
  State<SunriseSunsetCard> createState() => _SunriseSunsetCardState();
}

class _SunriseSunsetCardState extends State<SunriseSunsetCard> {
  late DateTime now;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (widget.sunriseTimestamp == 0 || widget.sunsetTimestamp == 0) {
      return const SizedBox();
    }

    final sunrise = DateTime.fromMillisecondsSinceEpoch(
      widget.sunriseTimestamp * 1000,
    );
    final sunset = DateTime.fromMillisecondsSinceEpoch(
      widget.sunsetTimestamp * 1000,
    );

    final timeFormat = DateFormat('HH:mm');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SUN",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white70 : AppTheme.primaryDarkBlue,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 12.sp),
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withOpacity(0.15) : Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              isDark
                  ? BoxShadow(color: Colors.transparent)
                  : BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
            ],
            border: isDark ? BoxBorder.all(color: Colors.white24) : Border(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "SUNRISE & SUNSET",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? Colors.white70
                          : AppTheme.secondaryDarkBlue,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              SizedBox(
                height: 70.h,
                width: double.infinity,
                child: CustomPaint(
                  painter: SunArcPainter(
                    sunrise: sunrise,
                    sunset: sunset,
                    now: now,
                  ),
                ),
              ),

              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimeColumn("SUNRISE", timeFormat.format(sunrise)),
                  _buildTimeColumn("NOW", timeFormat.format(now)),
                  _buildTimeColumn("SUNSET", timeFormat.format(sunset)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeColumn(String title, String time) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          time,
          style: TextStyle(
            fontSize: 16.sp,
            //   color: const Color(0xFF1E2432),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class SunArcPainter extends CustomPainter {
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime now;

  SunArcPainter({
    required this.sunrise,
    required this.sunset,
    required this.now,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.5;
    paint.strokeCap = StrokeCap.round;

    paint.shader = LinearGradient(
      colors: [Colors.orange.shade400, Colors.purple.shade200],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(10, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      -size.height * 0.5,
      size.width - 10,
      size.height,
    );
    canvas.drawPath(path, paint);
    int progress = now.millisecondsSinceEpoch - sunrise.millisecondsSinceEpoch;
    int total = sunset.millisecondsSinceEpoch - sunrise.millisecondsSinceEpoch;

    double t = (progress / total).clamp(0.0, 1.0);

    double startX = 10;
    double startY = size.height;

    double controlX = size.width / 2;
    double controlY = -size.height * 0.5;

    double endX = size.width - 10;
    double endY = size.height;

    double x =
        pow(1 - t, 2) * startX + 2 * (1 - t) * t * controlX + pow(t, 2) * endX;
    double y =
        pow(1 - t, 2) * startY + 2 * (1 - t) * t * controlY + pow(t, 2) * endY;

    canvas.drawCircle(
      Offset(x, y),
      8,
      Paint()
        ..color = Colors.amber.withOpacity(0.3)
        ..style = PaintingStyle.fill,
    );

    canvas.drawCircle(
      Offset(x, y),
      5,
      Paint()
        ..color = Colors.amber
        ..style = PaintingStyle.fill,
    );

    canvas.drawCircle(
      Offset(10, size.height),
      3,
      Paint()..color = Colors.orange.shade400,
    );
    canvas.drawCircle(
      Offset(size.width - 10, size.height),
      3,
      Paint()..color = Colors.purple.shade200,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
