import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sales_app/constants/colors.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/screens/onboarding/signup.dart';
import 'package:sales_app/widgets/button.dart';
import 'package:sales_app/widgets/inputs.dart';

class Login extends StatelessWidget {
  Login({super.key});
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().primary,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Lottie.asset("assets/images/login.json",fit: BoxFit.cover),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              height: MediaQuery.of(context).size.height * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
      
                    Padding(
                      padding: const EdgeInsets.only(top:18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Login",
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomInput(
                      enabled: true,
                      controller: authController.emailController,
                      hint: "Enter your email",
                      label: "Email",
                      icon: Icon(Icons.email),
                      obscure: false,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInput(
                      enabled: true,
                      controller: authController.passwordController,
                      hint: "Enter your password",
                      label: "Password",
                      icon: Icon(Icons.password),
                      obscure: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () {
                          authController.userLogin();
                        },
                        child: CustomButton(text: "Login")),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont have an account? ",
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(SignUp());
                          },
                          child: Text(
                            "Click here to sign up.",
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
