import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/widgets/tabview.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                padding: EdgeInsets.only(top: 60),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 1.0,
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Positioned(
                            bottom: -4,
                            right: -3,
                            child: InkWell(
                                onTap: () async {
                                  authController.image = (await authController
                                      .picker
                                      .pickImage(source: ImageSource.gallery))!;
                                  print(authController.image);
                                  await authController.uploadImage(
                                      authController.image.path,
                                      authController.image.name);
                                  await authController.uploadUserImage();
                                },
                                child: const Icon(Icons.camera))),
                        Obx(
                          () => CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                "${authController.userData.value!.profileimage}"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${authController.userData.value!.firstname} ${authController.userData.value!.lastname}",
                      style: GoogleFonts.lato(
                          fontSize: 25, color: Colors.grey[800]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${authController.userData.value!.email}",
                      style: GoogleFonts.lato(
                          fontSize: 15, color: Colors.grey[800]),
                    )
                  ],
                ),
              ),
              // Positioned(
              //   bottom: -120,
              //   right: 20,
              //   left: 20,
              //   child: Container(
              //     height: 150,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       border: Border.all(color: Colors.black),
              //       color: Colors.grey[200],
              //     ),
              //     padding: EdgeInsets.all(20),
              //     alignment: Alignment.center,
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Text(
              //           "Total Sales",
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 18,
              //               decoration: TextDecoration.none,
              //               color: Colors.black),
              //         ),
              //         SizedBox(
              //           height: 20,
              //         ),
              //         Text(
              //           "\$50,000",
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 14,
              //               decoration: TextDecoration.none,
              //               color: Colors.black),
              //         ),
              //         SizedBox(
              //           height: 20,
              //         ),
              //         Text(
              //           "Click here to view your shop",
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             fontSize: 15,
              //             decoration: TextDecoration.underline,
              //             color: Colors.black,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
           
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: CustomTabView(),
          )
        ],
      ),
    );
  }
}
