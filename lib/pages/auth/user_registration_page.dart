import 'dart:io';

import 'package:firstapp/controllers/registration_controller.dart';
import 'package:firstapp/pages/auth/login_page.dart';
import 'package:firstapp/widgets/main_button.dart';
import 'package:firstapp/widgets/main_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserRegistrationPage extends StatefulWidget {
  const UserRegistrationPage({super.key});

  @override
  State<UserRegistrationPage> createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
RegistrationController registrationController = Get.put(RegistrationController());
  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: CupertinoColors.activeGreen,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: CupertinoColors.destructiveRed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Center(
            child: ListView(
              children: [
                Icon(Icons.lock, size: 100.r),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome back you been missed',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16.sp),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // username
                MainTextField(
                  controller: registrationController.firstNameController,
                  hintText: "First Name",
                  obscureText: false,
                ),
                SizedBox(height: 20.h),
                // username
                MainTextField(
                  controller: registrationController.phoneController,
                  hintText: "Phone Number",
                  obscureText: false,
                ),
                //password
                SizedBox(height: 10.h),
                MainTextField(
                  controller: registrationController.passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 10.h),
                MainTextField(
                  controller: registrationController.confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                SizedBox(height: 10.h),

                SizedBox(height: 10.h),
                MainButton(
                  title: 'Registration',
                  onTap: () => registrationController.registration(),
                ),
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already registered?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(width: 10.w),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
