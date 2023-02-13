import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_app/constants/colors.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/models/user.dart';
import 'package:sales_app/widgets/tabview.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 60),
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 1.0,
                  decoration: BoxDecoration(
                      color: CustomColors().secondary,
                      borderRadius: const BorderRadius.only(
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
                              child: const Icon(
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
                                    authController.image =
                                        (await authController.picker.pickImage(
                                            source: ImageSource.gallery))!;
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
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${authController.userData.value!.firstname} ${authController.userData.value!.lastname}",
                        style: GoogleFonts.lato(
                            fontSize: 25, color: Colors.grey[800]),
                      ),
                      const SizedBox(
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
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: const CustomTabView(),
            )
          ],
        ),
      ),
    );
  }
}
