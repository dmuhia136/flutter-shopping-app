import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sales_app/functions/function.dart';
import 'package:sales_app/models/user.dart';
import 'package:sales_app/screens/homescreen.dart';
import 'package:sales_app/screens/welcome.dart';
import 'package:sales_app/service/userClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthController extends GetxController {
  RxBool isLoading = RxBool(false);
  // User user=User as User;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rxn<UserModel> userData = Rxn<UserModel>(null);

  Future<UserCredential> signInWithGoogle() async {
    isLoading.value = true;
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
    print(credential);
    isLoading.value = false;
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void onInit() {
    super.onInit();
    checkLogin();
  }

  checkLogin() async {
    try {
      if (Functions().userId() == null) {
        return null;
      }
      var response = await UserClient.fetchUser();
      print(response);
      if (response.length > 0) {
        userData.value = UserModel.fromJson(response['body']);
      }

      return response;
    } catch (e) {
      print("sdadsadadd $e");
    }
  }

  userLogin() async {
    try {
      Map<String, dynamic> user = {
        "email": emailController.text,
        "password": passwordController.text
      };
      final prefs = await SharedPreferences.getInstance();
      var response = await UserClient.createUser(user);
      if (response['status'] == false) {
        Get.snackbar("Error!!", response['message']);
      }
      await prefs.setString('userid', response['body']['_id'].toString());

      print(response['body']['_id']);
      userData.value = UserModel.fromJson(response['body']);
      Get.to(HomeScreen());
    } catch (e) {
      print(e);
    }
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await checkLogin();
    await Fluttertoast.showToast(
        msg: "You have been logged out.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
