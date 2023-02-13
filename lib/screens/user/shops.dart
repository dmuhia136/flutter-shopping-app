import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_app/controllers/authController.dart';

class Shops extends StatelessWidget {
  Shops({super.key});
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            ListTile(
                title: Text(
                  authController.userData.value!.shop!.name.toString(),
                ),
                subtitle:
                    Text("${authController.userData.value?.email.toString()} "),
                leading: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      authController.userData.value!.profileimage.toString()),
                ))
          ],
        ),
      ),
    );
  }
}
