import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  TextEditingController controller;
  String hint;
  String? label;
  Icon? icon;
  bool obscure;
  bool enabled;
  TextInputType? type;
  CustomInput(
      {super.key,
      required this.controller,
      required this.hint,
      this.label,
      this.icon,
      required this.enabled,
      required this.obscure,this.type});

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
          keyboardType:type ,
          
          decoration: InputDecoration(
          enabled: enabled,
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
