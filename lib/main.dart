import 'package:firstapp/components/sms/add_customer_screen.dart';
import 'package:firstapp/components/sms/sms.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override

  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: CustomerList(),
      home: AddCustomerScreen(),
    );
  }
}
