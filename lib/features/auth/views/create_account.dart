import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/widgets/custom_elevated_button.dart';
import 'package:weather_app/features/auth/views/sign_in.dart';
import 'package:weather_app/features/auth/views/widgets/custom_text_field.dart';
import 'package:weather_app/features/auth/views/widgets/phone_field.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
                    child: Icon(Icons.keyboard_backspace_rounded),
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
                  Text("Create an account to continue!"),
                  SizedBox(height: 32.h),
                  CustomTextField(
                    hint: "First name",
                    controller: fnameController,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hint: "Last name",
                    controller: lnameController,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(hint: "Email", controller: emailController),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: birthdateController,
                    hint: "dd/mm/yyyy",
                    isCalender: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDialog<DateTime>(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: SizedBox(
                              height: 380.h,
                              width: 320.w,
                              child: Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: AppTheme.primaryBlue,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black87,
                                  ),
                                ),
                                child: CalendarDatePicker(
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  onDateChanged: (DateTime date) {
                                    Navigator.pop(context, date);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );

                      if (pickedDate != null) {
                        // dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                        print(pickedDate);
                      }
                    },
                  ),
                  SizedBox(height: 8.h),
                  PhoneField(controller: phoneController),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hint: "Password",
                    isPassword: true,
                    controller: passwordController,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hint: "Confirm password",
                    isPassword: true,
                    controller: confirmPasswordController,
                  ),
                  SizedBox(height: 32.h),
                  CustomElevatedButton(
                    content: Text("Register"),
                    onPressed: () {},
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
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
    );
  }
}
