import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/screens/homescreen.dart';
import 'package:sales_app/widgets/inputs.dart';
import 'package:swipe_to/swipe_to.dart';

class Welcome extends StatelessWidget {
  Welcome({super.key});
  AuthController _authController = Get.put(AuthController());
  // FirebaseAuth user=Firebase
  String? user = FirebaseAuth.instance.currentUser?.email;
  var databse = FirebaseFirestore.instance;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    print("my user, ${user}");
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "E-commerce",
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'HAY MARKETS',
                    style: GoogleFonts.lato(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
         
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'First Online',
                    style: GoogleFonts.lato(
                        fontSize: 55,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Market',
                    style: GoogleFonts.lato(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1.0,
                child: Text(
                  'Our markets always provide fresh items from the local farmers, lets support local with us!.',
                  style: GoogleFonts.lato(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Colors.black38),
                  maxLines: 3,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.34,
                  width: MediaQuery.of(context).size.width * 1.0,
                  child: Image.asset(
                    'assets/images/colorful.jpg',
                    scale: 1.0,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                  )),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red[300]),
                child: SwipeTo(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black54,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            "SWIPE TO START",
                            style: GoogleFonts.lato(color: Colors.white),
                          )
                        ],
                      )),
                  onRightSwipe: () {
                    Get.to(HomeScreen());
                    print('Callback from Swipe To Right');
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text.rich(
                TextSpan(text: 'HOW TO SUPPORT ', children: [
                  TextSpan(
                      text: 'LOCAL FARMERS',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.redAccent)),
                ]),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
