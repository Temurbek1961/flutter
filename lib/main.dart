import 'package:firstapp/pages/auth/user_registration_page.dart';
import 'package:firstapp/pages/home/home_page.dart';
import 'package:firstapp/pages/auth/login_page.dart';
import 'package:firstapp/pages/user/add_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
  const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // home: CustomerList(),
          // home: AddCustomerScreen(),
          home: child,
        );
      },
      // child: HomePage(),
      // child: LoginPage(),
      child: UserRegistrationPage(),
      // child: AddUserScreen(),
    );
  }
}
