import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/utils/app_validators.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/core/widgets/custom_elevated_button.dart';
import 'package:weather_app/features/auth/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/cubit/auth_state.dart';
import 'package:weather_app/features/auth/views/widgets/custom_text_field.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ContainerBackground(
          content: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.h),
                      Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.keyboard_backspace_rounded),
                        ),
                      ),
                      SizedBox(height: 150.h),
                      Image.asset(
                        "assets/images/sad_cloud.png",
                        height: 200.h,
                        width: 200.w,
                      ),
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        textAlign: TextAlign.center,
                        "Don't worry! It happens. Please enter your email address to receive a reset link.",
                        style: TextStyle(
                          color: isDark ? Colors.grey : Colors.black45,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        hint: "Email",
                        controller: emailController,
                        validator: AppValidators.validateEmail,
                      ),
                      SizedBox(height: 24.h),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (ModalRoute.of(context)?.isCurrent != true) return;
                          if (state is AuthSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Email reset sent")),
                            );

                            Navigator.pop(context);
                          } else if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)),
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomElevatedButton(
                            content: state is AuthLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text("Reset Email"),
                            onPressed: () {
                              if (state is AuthLoading) {
                                return;
                              }
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().resetCubit(
                                  email: emailController.text,
                                );
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
