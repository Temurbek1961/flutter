import 'dart:convert';
import 'dart:io';

import 'package:firstapp/core/constants/api_values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithPhone() async {
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      };
      final Map body = {
        "phone": phoneController.text,
        "password": passwordController.text,
      };
      http.Response response = await http.post(
        Uri.parse(ApiValues.baseURL + ApiValues.login),
        body: jsonEncode(body),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['accessToken'] != 0) {
          var token = json['accessToken'];
          if (kDebugMode) {
            print(token);
          }
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          phoneController.clear();
          passwordController.clear();
          showDialog(
            context: Get.context!,
            builder: (context) => const SimpleDialog(
              title: Text('Sign In Successfully'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('Sign In Successfully')],
            ),
          );
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
