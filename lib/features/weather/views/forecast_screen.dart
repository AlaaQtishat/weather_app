// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:weather_app/core/constants/app_theme.dart';
// import 'package:weather_app/core/widgets/letter_widget.dart';
// import 'package:weather_app/features/user/cubit/user_cubit.dart';
// import 'package:weather_app/features/user/cubit/user_state.dart';
//
// class ForecastScreen extends StatelessWidget {
//   const ForecastScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(gradient: AppTheme.scaffoldGradient),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.w),
//           child: Column(
//             children: [
//               SizedBox(height: 60.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.pin_drop_outlined,
//                             color: Colors.grey,
//                             size: 16.sp,
//                           ),
//                           SizedBox(width: 2.w),
//                           Text(
//                             "Province of Turin",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         "7-Day Forecast",
//                         style: TextStyle(
//                           color: AppTheme.primaryDarkBlue,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 32.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                   BlocBuilder<UserCubit, UserState>(
//                     builder: (context, userState) {
//                       if (userState is UserLoaded) {
//                         final user = userState.user;
//                         return Column(
//                           children: [
//                             LetterWidget(letter: user.fname[0].toUpperCase()),
//                           ],
//                         );
//                       } else if (userState is UserError) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: 40.h),
//                           child: Text(userState.errorMessage),
//                         );
//                       } else if (userState is UserLoading) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: 40.h),
//                           child: const CircularProgressIndicator(),
//                         );
//                       }
//                       return SizedBox(height: 40.h);
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 24.h),
//               Container(
//                 decoration: BoxDecoration(
//                   color: theme.cardColor,
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(24.sp),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         children: [
//                           Image.asset(
//                             "assets/images/rain.png",
//                             height: 50.h,
//                             width: 50.w,
//                           ),
//                         ],
//                       ),
//                       SizedBox(width: 16.w),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "11",
//                             style: TextStyle(
//                               fontSize: 24.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             "Moderate Rain",
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 16.sp,
//                             ),
//                           ),
//                           Text("656  678 "),
//                         ],
//                       ),
//                       Spacer(),
//                       Column(children: [Text("Today"), Text("22/8/2026")]),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/core/widgets/header_section.dart';
import 'package:weather_app/core/widgets/letter_widget.dart';
import 'package:weather_app/features/user/cubit/user_cubit.dart';
import 'package:weather_app/features/user/cubit/user_state.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: ContainerBackground(
        content: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 60.h),

                HeaderSection(isHome: false),
                SizedBox(height: 24.h),

                Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 20.h,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/rain.png",
                          height: 60.h,
                          width: 60.w,
                        ),
                        SizedBox(width: 20.w),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "11°",
                              style: TextStyle(
                                fontSize: 42.sp,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryDarkBlue,
                                height: 1.0,
                              ),
                            ),
                            Text(
                              "Moderate Rain",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  size: 12.sp,
                                  color: Colors.grey,
                                ),
                                Text(
                                  " 13.7°   ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_downward,
                                  size: 12.sp,
                                  color: Colors.grey,
                                ),
                                Text(
                                  " 9.9°",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Today",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              "Wed 18 Sep",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                Row(
                  children: [
                    Text(
                      "This week",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.withOpacity(0.3),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                Column(
                  children: [
                    _buildDailyForecastCard(
                      "Thu",
                      "Sep 19",
                      Icons.cloudy_snowing,
                      "Light Showers",
                      "10°",
                      "14°",
                      Colors.blueAccent,
                      0.2,
                      0.5,
                      theme,
                    ),
                    _buildDailyForecastCard(
                      "Fri",
                      "Sep 20",
                      Icons.cloud,
                      "Partly Cloudy",
                      "11°",
                      "17°",
                      Colors.lightGreen,
                      0.1,
                      0.5,
                      theme,
                    ),
                    _buildDailyForecastCard(
                      "Sat",
                      "Sep 21",
                      Icons.sunny,
                      "Sunny",
                      "12°",
                      "21°",
                      Colors.orangeAccent,
                      0.1,
                      0.5,
                      theme,
                    ),
                    _buildDailyForecastCard(
                      "Sun",
                      "Sep 22",
                      Icons.sunny,
                      "Mostly Sunny",
                      "13°",
                      "22°",
                      Colors.orangeAccent,
                      0.1,
                      0.7,
                      theme,
                    ),
                    _buildDailyForecastCard(
                      "Mon",
                      "Sep 23",
                      Icons.cloud,
                      "Overcast",
                      "11°",
                      "18°",
                      Colors.blueAccent,
                      0.1,
                      0.6,
                      theme,
                    ),
                    _buildDailyForecastCard(
                      "Tue",
                      "Sep 24",
                      Icons.cloudy_snowing,
                      "Heavy Rain",
                      "9°",
                      "13°",
                      Colors.transparent,
                      0.0,
                      0.0,
                      theme,
                    ),

                    SizedBox(height: 80.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDailyForecastCard(
    String day,
    String date,
    IconData icon,
    String condition,
    String minTemp,
    String maxTemp,
    Color barColor,
    double startFraction,
    double widthFraction,
    ThemeData theme,
  ) {
    final double totalBarWidth = 60.w;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: AppTheme.primaryDarkBlue,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                ),
              ],
            ),
          ),

          Icon(icon, color: Colors.blueGrey.shade300),

          SizedBox(
            width: 70.w,
            child: Text(
              condition,
              style: TextStyle(color: Colors.grey, fontSize: 13.sp),
              maxLines: 2,
            ),
          ),

          Text(
            minTemp,
            style: TextStyle(color: Colors.grey, fontSize: 15.sp),
          ),

          SizedBox(
            width: totalBarWidth,
            height: 4.h,
            child: Stack(
              children: [
                Container(
                  width: totalBarWidth,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),

                Positioned(
                  left: totalBarWidth * startFraction,
                  child: Container(
                    width: totalBarWidth * widthFraction,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Text(
            maxTemp,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: AppTheme.primaryDarkBlue,
            ),
          ),
        ],
      ),
    );
  }
}
