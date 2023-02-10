import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
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
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rxn<UserModel> userData = Rxn<UserModel>(null);
  RxList<UserModel> allUsers = RxList<UserModel>([]);
  ImagePicker picker = ImagePicker();
  XFile image = XFile('');
  RxBool isUploading = RxBool(false);
  String imageUrl = "";
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

  @override
  void onInit() {
    super.onInit();
    checkLogin();
    fetchAllUsers();
  }

  checkLogin() async {
    try {
      if (Functions().userId() == null) {
        return null;
      }
      var response = await UserClient.fetchUser();
      userData.value = UserModel.fromJson(response['body']);
      return response;
    } catch (e) {
      print("$e");
    }
  }

  userLogin() async {
    try {
      Map<String, dynamic> user = {
        "email": emailController.text,
        "password": passwordController.text
      };
      final prefs = await SharedPreferences.getInstance();
      var response = await UserClient.loginUser(user);
      if (response['status'] == false) {
        Get.snackbar("Error!!", response['message']);
      }
      await prefs.setString('userid', response['body']['_id'].toString());
      userData.value = UserModel.fromJson(response['body']);
      clearControllers();
      Get.to(HomeScreen());
    } catch (e) {
      print(e);
    }
  }

  userSignUp() async {
    isLoading.value == true;
    Map<String, dynamic> user = {
      "email": emailController.text,
      "firstname": fnameController.text,
      "lastname": lnameController.text,
      "password": passwordController.text,
      "shop": '',
      "profileimage": ''
    };

    var response = await UserClient.createUser(user);
    print("iii ${response['body']}");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userid', response['body']['_id'].toString());

    userData.value = UserModel.fromJson(response['body']);
    Fluttertoast.showToast(msg: "Your account has been created.");
    clearControllers();
    Get.to(HomeScreen());
    isLoading.value == false;
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
    userData.value = null;
    clearControllers();
    Get.to(HomeScreen());
  }

  clearControllers() {
    emailController.clear();
    passwordController.clear();
    fnameController.clear();
    lnameController.clear();
  }

  uploadImage(String url, String name) async {
    try {
      isUploading.value = true;
      final _firebaseStorage = FirebaseStorage.instance;
      var file = File(url);
      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('images/$name')
            .putFile(file)
            .whenComplete(() => null);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        imageUrl = downloadUrl;
        Fluttertoast.showToast(
            msg: "Image uploaded",
            backgroundColor: Colors.green,
            textColor: Colors.black);
        isUploading.value = false;
      } else {
        Fluttertoast.showToast(
            msg: "Image upload failed",
            backgroundColor: Colors.red,
            textColor: Colors.white);
        isUploading.value = false;
      }
    } catch (e) {
      print(e);
    }
  }

  uploadUserImage() async {
    Map<String, dynamic> image = {"profileimage": imageUrl};
    var response = await UserClient.uploadUserImage(image);

    await checkLogin();
  }

  fetchAllUsers() async {
    var id = await Functions().userId();
    List response = await UserClient.fetchAllUsers();
  //  var data= response.where((element) => element.id != id);
    allUsers.assignAll(response.map((e) => UserModel.fromJson(e)));
  }
}
