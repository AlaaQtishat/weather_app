import 'package:dlibphonenumber/dlibphonenumber.dart' as dlib;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/widgets/custom_elevated_button.dart';
import 'package:weather_app/features/auth/controllers/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/controllers/cubit/auth_state.dart';
import 'package:weather_app/features/auth/models/user_model.dart';
import 'package:weather_app/features/auth/views/sign_in.dart';
import 'package:weather_app/features/auth/views/widgets/custom_text_field.dart';
import 'package:weather_app/features/auth/views/widgets/phone_field.dart';
import 'package:weather_app/features/weather/views/main_layout_screen.dart';
import 'package:intl/intl.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthdateController = TextEditingController();
  final phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String fullPhoneNumber = "";
  String selectedCountryCode = "JO";
  String? phoneError;

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    birthdateController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(gradient: AppTheme.scaffoldGradient),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h),

                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );
                      },
                      child: const Icon(Icons.keyboard_backspace_rounded),
                    ),

                    SizedBox(height: 28.h),

                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    const Text("Create an account to continue!"),

                    SizedBox(height: 32.h),

                    CustomTextField(
                      hint: "First name",
                      controller: fnameController,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Name is required";
                        }

                        if (val.trim().length < 2) {
                          return "Name must be at least 2 characters";
                        }

                        if (!RegExp(
                          r"^[a-zA-Z\u0600-\u06FF\s]+$",
                        ).hasMatch(val)) {
                          return "Please enter a valid name (letters only)";
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 8.h),

                    CustomTextField(
                      hint: "Last name",
                      controller: lnameController,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Name is required";
                        }

                        if (val.trim().length < 2) {
                          return "Name must be at least 2 characters";
                        }

                        if (!RegExp(
                          r"^[a-zA-Z\u0600-\u06FF\s]+$",
                        ).hasMatch(val)) {
                          return "Please enter a valid name (letters only)";
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 8.h),

                    CustomTextField(
                      hint: "Email",
                      controller: emailController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Email is required";
                        }

                        if (!RegExp(
                          r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$",
                        ).hasMatch(val)) {
                          return "Please enter a valid email address";
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 8.h),

                    CustomTextField(
                      controller: birthdateController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Birthdate is required";
                        }

                        return null;
                      },
                      hint: "dd/mm/yyyy",
                      isCalender: true,
                      onTap: () async {
                        DateTime initialDate = DateTime.now();
                        if (birthdateController.text.isNotEmpty) {
                          try {
                            initialDate = DateFormat(
                              'dd/MM/yyyy',
                            ).parse(birthdateController.text);
                          } catch (e) {
                            initialDate = DateTime.now();
                          }
                        }

                        DateTime selectedDate = initialDate;

                        DateTime? pickedDate = await showDialog<DateTime>(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: SizedBox(
                                height: 440.h,
                                width: 320.w,
                                child: Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: AppTheme.primaryBlue,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.black87,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: CalendarDatePicker(
                                          initialDate: initialDate,
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime(2100),
                                          onDateChanged: (DateTime date) {
                                            selectedDate = date;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                          vertical: 12.h,
                                        ),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 45.h,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppTheme.primaryBlue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                              ),
                                              elevation: 0,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(
                                                context,
                                                selectedDate,
                                              );
                                            },
                                            child: Text(
                                              "Confirm",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );

                        if (pickedDate != null) {
                          birthdateController.text = DateFormat(
                            'dd/MM/yyyy',
                          ).format(pickedDate);
                        }
                      },
                    ),

                    SizedBox(height: 8.h),

                    PhoneField(
                      controller: phoneController,
                      errorText: phoneError,
                      onChanged: (phone, countryCode) {
                        print("PHONE: $phone");
                        print("COUNTRY: $countryCode");

                        fullPhoneNumber = phone;
                        selectedCountryCode = countryCode;

                        if (phoneError != null) {
                          setState(() {
                            phoneError = null;
                          });
                        }
                      },
                    ),

                    SizedBox(height: 8.h),

                    CustomTextField(
                      hint: "Password",
                      isPassword: true,
                      controller: passwordController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Password is required";
                        }

                        if (val.length < 8) {
                          return "Password must be at least 8 characters";
                        }

                        if (!RegExp(r'[A-Z]').hasMatch(val)) {
                          return "Must contain at least one uppercase letter";
                        }

                        if (!RegExp(r'[a-z]').hasMatch(val)) {
                          return "Must contain at least one lowercase letter";
                        }

                        if (!RegExp(r'[0-9]').hasMatch(val)) {
                          return "Must contain at least one number";
                        }

                        if (!RegExp(r'[!@#\$&*~_=%^]+').hasMatch(val)) {
                          return "Must contain at least one special character";
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 8.h),

                    CustomTextField(
                      hint: "Confirm password",
                      isPassword: true,
                      controller: confirmPasswordController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Confirm Password is required";
                        }

                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          return "passwords don't match";
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 32.h),

                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (ModalRoute.of(context)?.isCurrent != true) return;
                        if (state is AuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Account created successfully!"),
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
                          content: state is AuthLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text("Register"),
                          onPressed: () {
                            if (state is AuthLoading) {
                              return;
                            }

                            final isFormValid = _formKey.currentState!
                                .validate();

                            final isPhoneValid = validatePhone();

                            if (!isFormValid || !isPhoneValid) {
                              return;
                            }

                            final user = UserModel(
                              email: emailController.text.trim(),
                              fname: fnameController.text.trim(),
                              lname: lnameController.text.trim(),
                              birthdate: birthdateController.text,
                              phoneNumber: fullPhoneNumber,
                            );

                            context.read<AuthCubit>().registerCubit(
                              user: user,
                              password: passwordController.text,
                            );
                          },
                        );
                      },
                    ),

                    SizedBox(height: 24.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => SignIn()),
                            );
                          },
                          child: Text(
                            "Log in",
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

  bool validatePhone() {
    if (fullPhoneNumber.trim().isEmpty) {
      setState(() {
        phoneError = "Phone number is required";
      });

      return false;
    }

    try {
      final phoneUtil = dlib.PhoneNumberUtil.instance;

      final parsedPhone = phoneUtil.parse(fullPhoneNumber, selectedCountryCode);

      if (!phoneUtil.isValidNumber(parsedPhone)) {
        setState(() {
          phoneError = "Please enter a valid phone number";
        });

        return false;
      }

      final numberType = phoneUtil.getNumberType(parsedPhone);

      if (numberType != dlib.PhoneNumberType.mobile &&
          numberType != dlib.PhoneNumberType.fixedLineOrMobile) {
        setState(() {
          phoneError = "Please enter a valid mobile number";
        });

        return false;
      }

      setState(() {
        phoneError = null;
      });

      return true;
    } catch (e) {
      print("PHONE VALIDATION ERROR: $e");

      setState(() {
        phoneError = "Please enter a valid phone number";
      });

      return false;
    }
  }
}
