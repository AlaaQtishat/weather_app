import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/utils/app_validators.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/core/widgets/custom_elevated_button.dart';
import 'package:weather_app/features/auth/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/cubit/auth_state.dart';
import 'package:weather_app/features/auth/services/remember_me_prefs.dart';
import 'package:weather_app/features/auth/views/create_account.dart';
import 'package:weather_app/features/auth/views/forget_password.dart';
import 'package:weather_app/features/auth/views/widgets/custom_text_field.dart';
import 'package:weather_app/features/weather/views/main_layout_screen.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RememberMePrefs prefs = RememberMePrefs();
  bool isRememberMeChecked = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedCredentials() async {
    final savedEmail = await prefs.getEmail();
    final savedPassword = await prefs.getPassword();
    if (savedEmail != null &&
        savedEmail.isNotEmpty &&
        savedPassword != null &&
        savedPassword.isNotEmpty) {
      setState(() {
        emailController.text = savedEmail;
        passwordController.text = savedPassword;
        isRememberMeChecked = true;
      });
    }
  }

  @override
  void initState() {
    _loadSavedCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ContainerBackground(
          content: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 120.h),
                    Text(
                      "Sign in to your\naccount",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Enter your email and password to log in ",
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      controller: emailController,
                      hint: "Email",
                      validator: AppValidators.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hint: "Password",
                      isPassword: true,
                      controller: passwordController,
                      validator: AppValidators.validatePassword,
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 12.w),
                            SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: Checkbox(
                                activeColor: AppTheme.primaryBlue,

                                value: isRememberMeChecked,

                                side: BorderSide(
                                  width: 2.w,
                                  color: Colors.black45,
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    isRememberMeChecked = val!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              "Remember me",
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ForgetPassword(),
                              ),
                            );
                          },
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(color: AppTheme.primaryBlue),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (ModalRoute.of(context)?.isCurrent != true) return;
                        if (state is AuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Signed in Successfully!"),
                            ),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainLayoutScreen(),
                            ),
                          );
                        } else if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomElevatedButton(
                          content:
                              state is AuthLoading &&
                                  state.loadingSource == "email"
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text("Log In"),
                          onPressed: () {
                            if (state is AuthLoading) {
                              return;
                            }
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().signinCubit(
                                email: emailController.text,
                                password: passwordController.text,
                                isRememberMe: isRememberMeChecked,
                              );
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade400)),
                        SizedBox(width: 12.w),
                        Text("Or", style: TextStyle(color: Colors.black45)),
                        SizedBox(width: 12.w),
                        Expanded(child: Divider(color: Colors.grey.shade500)),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (ModalRoute.of(context)?.isCurrent != true) return;
                        if (state is AuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Signed in Successfully!"),
                            ),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainLayoutScreen(),
                            ),
                          );
                        } else if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomElevatedButton(
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          content: Row(
                            children: [
                              SizedBox(width: 32.w),
                              SizedBox(
                                width: 40.w,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    "assets/images/google.png",
                                    height: 28.h,
                                    width: 28.w,
                                  ),
                                ),
                              ),

                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  "Continue with Google",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            if (state is AuthLoading) return;

                            FocusScope.of(context).unfocus();
                            context.read<AuthCubit>().googleSignInCubit();
                          },
                        );
                      },
                    ),

                    SizedBox(height: 8.h),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainLayoutScreen(),
                            ),
                          );
                        } else if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomElevatedButton(
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          content: Row(
                            children: [
                              SizedBox(width: 32.w),
                              SizedBox(
                                width: 40.w,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    "assets/images/facebook.png",
                                    height: 28.h,
                                    width: 28.w,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  "Continue with Facebook",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            if (state is AuthLoading) return;
                            if (state is AuthLoading) return;
                            context.read<AuthCubit>().facebookSignInCubit();
                          },
                        );
                      },
                    ),

                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CreateAccount(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: AppTheme.primaryBlue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
