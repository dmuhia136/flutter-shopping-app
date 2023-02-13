import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_app/constants/colors.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/screens/profile.dart';
import 'package:sales_app/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(Profile());
            },
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  authController.userData.value!.profileimage.toString()),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              "${authController.userData.value!.firstname} ${authController.userData.value!.lastname}"),
          SizedBox(
            height: 10,
          ),
          Text("${authController.userData.value!.email} "),
          SizedBox(
            height: 10,
          ),
          Text("${authController.userData.value!.shop!.name} "),
          SizedBox(
            height: 10,
          ),
          Text("${authController.userData.value!.shop!.location} "),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(() => Profile());
            },
            child: Container(
              decoration: BoxDecoration(
                  color: CustomColors().secondary,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Visit profile",
                  style: GoogleFonts.lato(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(""),
          ),
          InkWell(
            onTap: () {
              authController.logout();
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Logout"),
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 7, 156, 182)),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ])).animate().fade(delay: Duration(microseconds: 100)).shimmer();
  }
}
