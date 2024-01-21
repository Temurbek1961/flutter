import 'dart:convert';
import 'dart:io';

import 'package:firstapp/widgets/main_button.dart';
import 'package:firstapp/widgets/main_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class AddUserScreen extends StatefulWidget {
  final String? id;
  final String? name;
  final String? age;
  final String? role;

  const AddUserScreen({super.key, this.id, this.name, this.age, this.role});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _langController = TextEditingController();
  final TextEditingController _periodDayController = TextEditingController();
  final TextEditingController _ndybfController = TextEditingController();
  final TextEditingController _timeZoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _nameController.text = widget.name ?? '';
    // _ageController.text = widget.age ?? '';
    // _roleController.text = widget.role ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text('Add User'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: ScreenUtil.defaultSize.height - kToolbarHeight - kBottomNavigationBarHeight,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              children: [
                MainTextField(controller: _firstNameController, hintText: 'Firstname', obscureText: false),
                SizedBox(height: 10.h),
                MainTextField(controller: _lastNameController, hintText: 'Lastname', obscureText: false),
                SizedBox(height: 10.h),
                MainTextField(controller: _phoneController, hintText: 'Phone number', obscureText: false),
                SizedBox(height: 10.h),
                MainTextField(controller: _langController, hintText: 'Lang', obscureText: false),
                SizedBox(height: 10.h),
                MainTextField(controller: _periodDayController, hintText: 'Period day', obscureText: false),
                SizedBox(height: 10.h),
                MainTextField(controller: _ndybfController, hintText: 'Notification day before', obscureText: false),
                SizedBox(height: 10.h),
                MainTextField(controller: _timeZoneController, hintText: 'Time Zone', obscureText: false),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, bottom: 30.h, right: 20.w),
            child: MainButton(
              onTap: _submitData,
              title: 'Add user',
            ),
          ),
        ],
      ),
    );
  }

  static const String token = '';

  Future<void> _submitData() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final phone = _phoneController.text;
    final lang = _langController.text;
    final periodDay = int.parse(_periodDayController.text.toString());
    final ndybf = int.parse(_ndybfController.text.toString());
    final timeZone = _timeZoneController.text;

    final body = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "language": lang,
      "period_day": periodDay,
      "notification_day_before": ndybf,
      "time_zone": timeZone,
    };

    const uri = 'https://api.dostonbarber.uz/api/user/create';
    final url = Uri.parse(uri);

    try{
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Creation Success');
          print(response.body);
        }
        showSuccessMessage('Creation Success');
        Future.delayed(
          const Duration(seconds: 3),
              () {
            Navigator.pop(context);
          },
        );
      } else {
        if (kDebugMode) {
          print(response);
          print(response.reasonPhrase);
        }
        showErrorMessage('Creation Failed');
      }
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }  
    }



  }

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
}
