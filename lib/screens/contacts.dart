import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_app/constants/colors.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/models/user.dart';
import 'package:sales_app/screens/chat.dart';

class Contacts extends StatelessWidget {
  Contacts({super.key});
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                color: CustomColors().primary,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back_ios)),
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        "Contacts",
                        style: GoogleFonts.lato(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 07,
                child: ListView.separated(
                    separatorBuilder: (BuildContext context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: authController.allUsers.length,
                    itemBuilder: (ctx, index) {
                      UserModel user = authController.allUsers.elementAt(index);
                      return ListTile(
                        onTap: () {
                          Get.to(Chat(index: index,user: user,));
                        },
                        title: Text(
                          "${user.firstname} ${user.lastname}",
                        ),
                        leading: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              NetworkImage(user.profileimage.toString()),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
