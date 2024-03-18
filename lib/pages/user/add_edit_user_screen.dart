import 'dart:convert';
import 'dart:io';

import 'package:firstapp/core/constants/api_values.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/pages/home/home_page.dart';
import 'package:firstapp/widgets/main_button.dart';
import 'package:firstapp/widgets/main_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class AddUserScreen extends StatefulWidget {
  final String? id;
  final UserModel? user;

  const AddUserScreen({super.key, this.id, this.user});

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
  List<UserModel> userList = [];

  bool isEdit = false;

  Future<UserModel?> fetchUserWithId(String id) async {
    var headers = {'Authorization': 'Bearer ${ApiValues.API_KEY_VALUE['value']}'};
    final response = await http.get(
      Uri.parse(ApiValues.baseURL + ApiValues.userList),
      headers: headers,
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        List data = body['data'];
        data = data.map((json) {
          return UserModel.fromJson(json);
        }).toList();
        for (UserModel user in data) {
          if (user.id == id) {
            return user;
          }
        }
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      if (kDebugMode) {
        print('${e}error');
      }
      return null;
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.user != null) {
      isEdit = true;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _langController.dispose();
    _periodDayController.dispose();
    _ndybfController.dispose();
    _timeZoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(isEdit ? 'Edit User' : 'Add User'),
      ),
      body: FutureBuilder(
        future: fetchUserWithId(widget.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel user = snapshot.data!;
            return ListView(
              children: [
                SizedBox(
                  height: ScreenUtil.defaultSize.height - kToolbarHeight - kBottomNavigationBarHeight,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    children: [
                      MainTextField(controller: _firstNameController, initValue: user.firstName, hintText: 'Firstname', obscureText: false),
                      SizedBox(height: 10.h),
                      MainTextField(controller: _lastNameController, initValue: user.lastName, hintText: 'Lastname', obscureText: false),
                      SizedBox(height: 10.h),
                      MainTextField(controller: _phoneController, initValue: user.phone, hintText: 'Phone number', obscureText: false),
                      SizedBox(height: 10.h),
                      MainTextField(controller: _langController, initValue: user.lang, hintText: 'Lang', obscureText: false),
                      SizedBox(height: 10.h),
                      MainTextField(controller: _periodDayController, initValue: user.periodDay.toString(), hintText: 'Period day', obscureText: false),
                      SizedBox(height: 10.h),
                      MainTextField(controller: _ndybfController, initValue: user.ndybf.toString(), hintText: 'Notification day before', obscureText: false),
                      SizedBox(height: 10.h),
                      MainTextField(controller: _timeZoneController, initValue: user.timeZone, hintText: 'Time Zone', obscureText: false),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, bottom: 30.h, right: 20.w),
                  child: MainButton(
                    onTap: () async {
                      print('on tap');
                      isEdit ? await _editData(widget.id!) : await _submitData();
                    },
                    title: isEdit ? 'Edit user' : 'Add user',
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  static const String token = '';

  Future<void> _submitData() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final phone = _phoneController.text;
    final lang = _langController.text;
    final periodDay = _periodDayController.text.isNotEmpty ? int.parse(_periodDayController.text.toString()) : null;
    final ndybf = _ndybfController.text.isNotEmpty ? int.parse(_ndybfController.text.toString()) : null;
    final timeZone = _timeZoneController.text;
    var headers = {
      HttpHeaders.authorizationHeader: 'Bearer ${ApiValues.API_KEY_VALUE['value']}',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };
    final body = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "language": lang,
      "period_day": periodDay,
      "notification_day_before": ndybf,
      "time_zone": timeZone,
    };

    const uri = ApiValues.baseURL + ApiValues.createUser;
    final url = Uri.parse(uri);

    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
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
            Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
          },
        );
      } else {
        if (kDebugMode) {
          print(response);
          print(response.reasonPhrase);
        }
        showErrorMessage('Creation Failed');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> _editData(String id) async {
    final user = widget.user;
    if (user == null) {
      if (kDebugMode) {
        print('You can not call updated without user data');
      }
      return;
    }
    final id = user.id;
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final phone = _phoneController.text;
    final lang = _langController.text;
    final periodDay = int.parse(_periodDayController.text.toString());
    final ndybf = int.parse(_ndybfController.text.toString());
    final timeZone = _timeZoneController.text;

    // int index = users.indexWhere((user) => user.id == id);
    final body = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "language": lang,
      "period_day": periodDay,
      "notification_day_before": ndybf,
      "time_zone": timeZone,
    };
    UserModel updatedUser = UserModel().copyWith(
      id: id,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      lang: lang,
      periodDay: periodDay,
      ndybf: ndybf,
      timeZone: timeZone,
    );

    final uri = ApiValues.baseURL + ApiValues(id: id).updateUserById;
    final url = Uri.parse(uri);

    try {
      final response = await http.patch(
        url,
        body: jsonEncode(body),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${ApiValues.API_KEY_VALUE['value']}',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Updated Success');
          print(response.body);
        }
        showSuccessMessage('Updated Success');
        Future.delayed(
          const Duration(seconds: 3),
          () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
          },
        );
      } else {
        if (kDebugMode) {
          print(response);
          print(response.reasonPhrase);
        }
        showErrorMessage('Updated Failed');
      }
    } catch (e) {
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
