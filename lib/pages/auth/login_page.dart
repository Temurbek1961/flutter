import 'dart:io';

import 'package:firstapp/controllers/login_controller.dart';
import 'package:firstapp/generated/assets.dart';
import 'package:firstapp/pages/auth/user_registration_page.dart';
import 'package:firstapp/pages/home/home_page.dart';
import 'package:firstapp/widgets/main_button.dart';
import 'package:firstapp/widgets/main_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  // sign user in method
  // Future<void> _signIn(String phone, String password) async {
  //   try {
  //     http.Response response = await http.post(
  //       Uri.parse(ApiValues.baseURL + ApiValues.signUp),
  //       body: {
  //         'phone': phone,
  //         'password': password,
  //       },
  //     );
  //   } catch (e) {}
  // }

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
                Text(
                  'Welcome back you been missed',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16.sp),
                ),
                SizedBox(height: 20.h),
                // username
                MainTextField(
                  controller: loginController.phoneController,
                  hintText: "Phone Number",
                  obscureText: false,
                ),
                //password
                SizedBox(height: 10.h),
                MainTextField(
                  controller: loginController.passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                MainButton(
                  title: 'Sign In',
                  onTap: () {
                    loginController.loginWithPhone();
                    // _signIn(
                    //   _phoneController.text.toString(),
                    //   _passwordController.text.toString(),
                    // );
                    Navigator.pushAndRemoveUntil(
                      context,
                      Platform.isIOS
                          ? CupertinoPageRoute(
                              builder: (_) => const HomePage(),
                            )
                          : MaterialPageRoute(
                              builder: (_) => const HomePage(),
                            ),
                      (route) => false,
                    );
                  },
                ),
                SizedBox(height: 50.h),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: InkWell(
                    onTap: () {},
                    focusColor: Colors.green,
                    hoverColor: Colors.red,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white,
                      ),
                      width: ScreenUtil.defaultSize.width,
                      height: 50.h,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.assetsGoogle,
                            width: 30.sp,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            'Sign In With Google',
                            style: TextStyle(color: Colors.black, fontSize: 16.sp),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        Platform.isIOS
                            ? CupertinoPageRoute(
                                builder: (_) => const UserRegistrationPage(),
                              )
                            : MaterialPageRoute(
                                builder: (_) => const UserRegistrationPage(),
                              ),
                      ),
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
