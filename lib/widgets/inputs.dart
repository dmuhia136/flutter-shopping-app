import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  TextEditingController controller;
  String hint;
  String? label;
  CustomInput({super.key, required this.controller, required this.hint,this.label});

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
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: hint, label: Text("$label")),
        ),
      ),
    );
  }
}
