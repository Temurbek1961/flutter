import 'dart:convert';
import 'dart:io';

import 'package:firstapp/core/constants/api_values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends GetxController {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registration() async {
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      };
      final Map body = {
        "first_name": firstNameController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
        "confirm_password": confirmPasswordController.text,
      };
      http.Response response = await http.post(
        Uri.parse(ApiValues.baseURL + ApiValues.signUp),
        body: jsonEncode(body),
        headers: headers,
      );
      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        if (json['code'] == 0) {
          var token = json['data']['token'];
          if (kDebugMode) {
            print(token);
          }
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          firstNameController.clear();
          phoneController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
        } else {
          throw jsonDecode(response.body)['message'] ?? 'Unknown error occurred';
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? 'Unknown error occurred';
      }
    } catch (e) {
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) => SimpleDialog(
          title: const Text('error'),
          contentPadding: const EdgeInsets.all(20),
          children: [Text(e.toString())],
        ),
      );
    }
  }
}
