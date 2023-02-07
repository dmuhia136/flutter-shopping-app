import 'package:flutter/material.dart';
import 'package:sales_app/constants/colors.dart';

class CustomButton extends StatelessWidget {
  String text;
  CustomButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 90, right: 90, top: 20, bottom: 20),
      decoration: BoxDecoration(
          color: CustomColors().secondary,
          borderRadius: BorderRadius.circular(30)),
      child: Text(text),
    );
  }
}
