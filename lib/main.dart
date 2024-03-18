import 'package:firstapp/pages/auth/login_page.dart';
import 'package:firstapp/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  dynamic token;

  Future<void> getToken() async {
    final SharedPreferences prefs = await _prefs;

    token = prefs.get('token');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: token != null ? const HomePage() : const LoginPage(),
      // child: AddUserScreen(),
    );
  }
}
