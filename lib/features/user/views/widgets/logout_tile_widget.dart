import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/auth/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/cubit/auth_state.dart';
import 'package:weather_app/features/auth/views/sign_in.dart';
import 'package:weather_app/features/search/cubit/recents_cubit.dart';
import 'package:weather_app/features/user/cubit/user_cubit.dart';
import 'package:weather_app/features/user/views/widgets/profile_tile_widget.dart';

class LogoutTileWidget extends StatelessWidget {
  const LogoutTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, authState) {
        if (authState is AuthInitial) {
          context.read<UserCubit>().clearUserData();
          context.read<RecentsCubit>().clearStateOnLogout();
          ScaffoldMessenger.of(context).clearSnackBars();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignIn()),
            (Route<dynamic> route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Signed out successfully!")),
          );
        } else if (authState is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(authState.errorMessage)));
        }
      },
      builder: (context, authState) {
        return InkWell(
          onTap: () {
            if (authState is AuthLoading) return;

            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                backgroundColor: isDark
                    ? AppTheme.primaryDarkBlue
                    : Colors.white,
                title: const Text(
                  "Logout?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: const Text("Are you sure you want to logout?"),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      context.read<AuthCubit>().logoutCubit();
                    },
                    child: authState is AuthLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Yes",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            );
          },
          child: ProfileTileWidget(
            img: "assets/images/logout.png",
            title: "Log out",
            trailingWidget: Padding(
              padding: const EdgeInsets.all(12.0),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
