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
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Shop name: ",
                        style: GoogleFonts.lato(fontSize: 20),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        authController.userData.value!.shop!.name.toString(),
                        style: GoogleFonts.lato(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Shop location: ",
                        style: GoogleFonts.lato(fontSize: 20),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        authController.userData.value!.shop!.location
                            .toString(),
                        style: GoogleFonts.lato(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
