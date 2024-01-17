import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUserScreen extends StatefulWidget {
  final String? id;
  final String? name;
  final int? age;
  final String? role;

  const AddUserScreen({super.key, this.id, this.name, this.age, this.role});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.name ?? '';
    _ageController.text = widget.age.toString() ?? '';
    _roleController.text = widget.role ?? '';
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                hintText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _roleController,
              decoration: const InputDecoration(
                hintText: 'Role',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 350),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _submitData,
              child: const Text('Add'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitData() async {
    final name = _nameController.text;
    final age = int.parse(_ageController.text.toString());
    final rol = _roleController.text;
    final body = {
      'title': name,
      'description': age.toString() + rol,
      // 'role': rol,
      'is_completed': false,
    };

    const uri = 'https://api.nstack.in/v1/todos';
    final url = Uri.parse(uri);
    final response = await http.post(
      url,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 201) {
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
      showErrorMessage('Creation Failed');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
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
      duration: Duration(seconds: 2),

      backgroundColor: CupertinoColors.destructiveRed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
