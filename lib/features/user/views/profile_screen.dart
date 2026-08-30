import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/theme/cubit/theme_cubit.dart';
import 'package:weather_app/core/theme/cubit/theme_state.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/features/auth/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/cubit/auth_state.dart';
import 'package:weather_app/features/auth/views/sign_in.dart';
import 'package:weather_app/core/widgets/letter_widget.dart';
import 'package:weather_app/features/search/cubit/recents_cubit.dart';
import 'package:weather_app/features/user/cubit/user_cubit.dart';
import 'package:weather_app/features/user/cubit/user_state.dart';
import 'package:weather_app/features/user/views/widgets/profile_tile_widget.dart';
import 'package:weather_app/features/user/views/widgets/profile_card_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: ContainerBackground(
        content: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 80.h),
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, userState) {
                    if (userState is UserLoaded) {
                      final user = userState.user;
                      return Column(
                        children: [
                          LetterWidget(
                            letter: user.fname[0].toUpperCase(),
                            isProfileScreen: true,
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            "${user.fname} ${user.lname}",
                            style: TextStyle(
                              //     color: AppTheme.primaryDarkBlue,
                              fontWeight: FontWeight.w800,
                              fontSize: 32.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            user.email,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white70
                                  : AppTheme.secondaryDarkBlue,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      );
                    } else if (userState is UserError) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        child: Text(userState.errorMessage),
                      );
                    } else if (userState is UserLoading) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        child: const CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(height: 40.h);
                  },
                ),

                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "PREFERENCES",
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      // color: AppTheme.primaryDarkBlue,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                ProfileCardWidget(
                  items: [
                    ProfileTileWidget(
                      isPreference: true,
                      img: "assets/images/temperature.png",
                      imgBgColor: const Color(0xFFFDECEE),
                      title: "Temperature",
                      trailingWidget: Text(
                        "Celsius",
                        style: TextStyle(
                          fontSize: 14.sp,
                          // color: const Color(0xFF7B8BA4),
                        ),
                      ),
                    ),

                    ProfileTileWidget(
                      isPreference: true,
                      img: "assets/images/time.png",
                      imgBgColor: const Color(0xFFF1F4F9),
                      title: "Time Format",
                      trailingWidget: Text(
                        "24h",
                        style: TextStyle(
                          fontSize: 14.sp,
                          // color: const Color(0xFF7B8BA4),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "SETTINGS",
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      //      color: AppTheme.primaryDarkBlue,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                ProfileCardWidget(
                  items: [
                    ProfileTileWidget(
                      img: isDark
                          ? "assets/images/darktheme.png"
                          : "assets/images/lighttheme.png",
                      imgBgColor: const Color(0xFFFDECEE),
                      title: "Theme",
                      trailingWidget: BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, state) {
                          bool isDarkMode = state.themeMode == ThemeMode.dark;

                          return Switch(
                            value: isDarkMode,
                            activeColor: isDark
                                ? AppTheme.primaryLightBlue
                                : AppTheme.primaryBlue,
                            onChanged: (newValue) {
                              context.read<ThemeCubit>().toggleTheme(newValue);
                            },
                          );
                        },
                      ),
                    ),

                    ProfileTileWidget(
                      img: "assets/images/logout.png",
                      imgBgColor: const Color(0xFFF1F4F9),
                      title: "Log out",
                      trailingWidget: BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, authState) {
                          if (authState is AuthInitial) {
                            final messenger = ScaffoldMessenger.of(context);
                            final navigator = Navigator.of(context);

                            messenger.clearSnackBars();

                            navigator.pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => SignIn()),
                              (Route<dynamic> route) => false,
                            );

                            messenger.showSnackBar(
                              const SnackBar(
                                content: Text("signed out successfully!"),
                              ),
                            );
                          } else if (authState is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(authState.errorMessage)),
                            );
                          }
                        },

                        builder: (context, authState) {
                          return IconButton(
                            icon: Icon(Icons.arrow_forward_ios_rounded),
                            onPressed: () {
                              if (authState is AuthLoading) {
                                return;
                              }
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: isDark
                                      ? AppTheme.primaryDarkBlue
                                      : Colors.white,
                                  title: Text(
                                    "Logout?",

                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // color: AppTheme.primaryDarkBlue,
                                    ),
                                  ),
                                  content: Text(
                                    "Are you sure you want to logout?",
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        context.read<RecentsCubit>().clearAll();
                                        context.read<AuthCubit>().logoutCubit();
                                      },
                                      child: authState is AuthLoading
                                          ? CircularProgressIndicator()
                                          : Text(
                                              "Yes",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
