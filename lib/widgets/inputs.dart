import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  TextEditingController controller;
  String hint;
  String? label;
  Icon? icon;
  bool obscure;
  CustomInput(
      {super.key,
      required this.controller,
      required this.hint,
      this.label,
      this.icon,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.tealAccent,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          obscureText: obscure,
          controller: controller,
          decoration: InputDecoration(
              icon: icon,
              labelStyle: TextStyle(color: Colors.black),
              border: InputBorder.none,
              hintText: hint,
              label: Text("$label")),
        ),
      ),
    );
  }
}
