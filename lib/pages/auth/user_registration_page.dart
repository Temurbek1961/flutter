import 'dart:convert';
import 'dart:io';

import 'package:firstapp/controllers/registration_controller.dart';
import 'package:firstapp/core/constants/api_values.dart';
import 'package:firstapp/pages/auth/login_page.dart';
import 'package:firstapp/widgets/main_button.dart';
import 'package:firstapp/widgets/main_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserRegistrationPage extends StatefulWidget {
  const UserRegistrationPage({super.key});

  @override
  State<UserRegistrationPage> createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // sign user in method
  // Future<void> _signUP(
  //   BuildContext context,
  //   String firstName,
  //   String phone,
  //   String password,
  //   String confirmPassword,
  // ) async {
  //
  //   try {
  //     if (password == confirmPassword) {
  //
  //       if (response.statusCode == 200) {
  //         if (kDebugMode) {
  //           print('User created');
  //           print(response.body);
  //         }
  //         showSuccessMessage('Creation Success');
  //
  //         await Future.delayed(
  //           const Duration(seconds: 3),
  //           () {
  //             Navigator.pushReplacement(
  //               context,
  //               Platform.isIOS
  //                   ? CupertinoPageRoute(
  //                       builder: (context) => const LoginPage(),
  //                     )
  //                   : MaterialPageRoute(
  //                       builder: (context) => const LoginPage(),
  //                     ),
  //               // (route) => false,
  //             );
  //           },
  //         );
  //       } else {
  //         if (kDebugMode) {
  //           print(response.reasonPhrase);
  //           print('failed');
  //         }
  //         showErrorMessage('Creation Failed');
  //       }
  //     } else {
  //       print('confirm password is not allowed');
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //   }
  // }
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
                  // onTap: () async {
                  //   String firstName = _firstNameController.text;
                  //   String phone = _phoneController.text;
                  //   String password = _passwordController.text;
                  //   String confirmPassword = _confirmPasswordController.text;
                  //   final Map body = {
                  //     "first_name": firstName,
                  //     "phone": phone,
                  //     "password": password,
                  //     "confirm_password": confirmPassword,
                  //   };
                  //   try {
                  //     http.Response response = await http.post(
                  //       Uri.parse(ApiValues.baseURL + ApiValues.signUp),
                  //       body: jsonEncode(body),
                  //       headers: {
                  //         HttpHeaders.contentTypeHeader: 'application/json',
                  //         HttpHeaders.acceptHeader: 'application/json',
                  //       },
                  //     );
                  //     // print(response.reasonPhrase);
                  //     if (response.statusCode == 201) {
                  //       if (kDebugMode) {
                  //         // print('User created');
                  //         print(response.body);
                  //       }
                  //       showSuccessMessage('Creation Success');
                  //
                  //       await Future.delayed(
                  //         const Duration(seconds: 3),
                  //         () {
                  //           Navigator.pushReplacement(
                  //             context,
                  //             Platform.isIOS
                  //                 ? CupertinoPageRoute(
                  //                     builder: (context) => const LoginPage(),
                  //                   )
                  //                 : MaterialPageRoute(
                  //                     builder: (context) => const LoginPage(),
                  //                   ),
                  //             // (route) => false,
                  //           );
                  //         },
                  //       );
                  //     } else {
                  //       if (kDebugMode) {
                  //         print(response.reasonPhrase);
                  //         print(response.statusCode);
                  //         // print('failed');
                  //       }
                  //       showErrorMessage('Creation Failed');
                  //     }
                  //   } catch (e) {
                  //     if (kDebugMode) {
                  //       print('fail');
                  //       print(e.toString());
                  //     }
                  //   }
                  //   // _signUP(
                  //   //   context,
                  //   //   _firstNameController.text.toString(),
                  //   //   _phoneController.text.toString(),
                  //   //   _passwordController.text.toString(),
                  //   //   _confirmPasswordController.text.toString(),
                  //   // );
                  // },
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
                      onPressed: () => Navigator.push(
                        context,
                        Platform.isIOS
                            ? CupertinoPageRoute(
                                builder: (_) => const LoginPage(),
                              )
                            : MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                      ),
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
