import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? initValue;

  const MainTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.initValue,
  });

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  late TextEditingController fieldController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fieldController = widget.controller;
    var variableName = widget.initValue;
    if (variableName != null && variableName == 'null') {
      variableName = null;
    }
    fieldController.text = variableName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
      ),
    );
  }
}
