import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_app/constants/colors.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/screens/onboarding/login.dart';
import 'package:sales_app/widgets/button.dart';
import 'package:sales_app/widgets/inputs.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors().primary,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "SignUp",
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                CustomInput(
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
                  controller: authController.fnameController,
                  hint: "Enter your first name",
                  label: "First Name",
                  icon: Icon(Icons.person),
                  obscure: false,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                  controller: authController.lnameController,
                  hint: "Enter your last name",
                  label: "Last Name",
                  icon: Icon(Icons.person),
                  obscure: false,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomInput(
                  controller: authController.passwordController,
                  hint: "Enter your password",
                  label: "Password",
                  icon: Icon(Icons.password),
                  obscure: true,
                ),
                SizedBox(
                  height: 20,
                ),
                authController.isLoading.value == true
                    ? Center(child: CircularProgressIndicator())
                    : InkWell(
                        onTap: () {
                          authController.userSignUp();
                        },
                        child: CustomButton(text: "Sign Up")),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(Login());
                      },
                      child: Text(
                        "Click here to sign in.",
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
