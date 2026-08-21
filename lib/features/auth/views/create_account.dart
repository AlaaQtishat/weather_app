import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/utils/app_validators.dart';
import 'package:weather_app/core/widgets/custom_elevated_button.dart';
import 'package:weather_app/features/auth/controllers/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/controllers/cubit/auth_state.dart';
import 'package:weather_app/features/auth/models/user_model.dart';
import 'package:weather_app/features/auth/views/sign_in.dart';
import 'package:weather_app/features/auth/views/widgets/custom_text_field.dart';
import 'package:weather_app/features/weather/views/main_layout_screen.dart';
import 'package:intl/intl.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthdateController = TextEditingController();
  final phoneController = TextEditingController();
  String selectedCountryCode = 'JO';
  String selectedDialCode = '+962';
  String selectedFlag = '🇯🇴';

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
                      validator: AppValidators.validateFname,
                    ),

                    SizedBox(height: 8.h),

                    CustomTextField(
                      hint: "Last name",
                      controller: lnameController,
                      validator: AppValidators.validateLname,
                    ),

                    SizedBox(height: 8.h),

                    CustomTextField(
                      hint: "Email",
                      controller: emailController,
                      validator: AppValidators.validateEmail,
                    ),

                    SizedBox(height: 8.h),

                    CustomTextField(
                      controller: birthdateController,
                      validator: AppValidators.validateBirthdate,

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
                    CustomTextField(
                      hint: "Phone Number",
                      controller: phoneController,
                      isPhoneNumber: true,
                      keyboardType: TextInputType.phone,
                      countryFlag: selectedFlag,
                      countryDialCode: selectedDialCode,
                      onCountryTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          countryListTheme: CountryListThemeData(
                            flagSize: 26.sp,
                            backgroundColor: Colors.blueGrey.shade50,
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black87,
                            ),

                            bottomSheetHeight: 500.h,

                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.r),
                              topRight: Radius.circular(24.r),
                            ),

                            inputDecoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).cardColor,
                              hintText: 'Search for a country',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.sp,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey.shade100,
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppTheme.primaryBlue,
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          ),

                          onSelect: (Country country) {
                            setState(() {
                              selectedCountryCode = country.countryCode;
                              selectedDialCode = '+${country.phoneCode}';
                              selectedFlag = country.flagEmoji;
                            });
                          },
                        );
                      },
                      validator: (val) {
                        String fullPhone =
                            selectedDialCode + (val ?? '').trim();

                        return AppValidators.validatePhone(
                          val,
                          fullPhone,
                          selectedCountryCode,
                        );
                      },
                    ),

                    SizedBox(height: 8.h),

                    CustomTextField(
                      hint: "Password",
                      isPassword: true,
                      controller: passwordController,
                      validator: AppValidators.validatePassword,
                    ),

                    SizedBox(height: 8.h),

                    CustomTextField(
                      hint: "Confirm password",
                      isPassword: true,
                      controller: confirmPasswordController,
                      validator: (val) => AppValidators.validateConfirmPassword(
                        val,
                        passwordController.text,
                      ),
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
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            String finalPhoneNumber =
                                selectedDialCode + phoneController.text.trim();

                            final user = UserModel(
                              email: emailController.text.trim(),
                              fname: fnameController.text.trim(),
                              lname: lnameController.text.trim(),
                              birthdate: birthdateController.text,
                              phoneNumber: finalPhoneNumber,
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
}
