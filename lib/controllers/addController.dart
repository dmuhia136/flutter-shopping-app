import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_app/screens/homescreen.dart';
import 'package:sales_app/screens/messages.dart';
import 'package:sales_app/screens/profile.dart';

class AddController extends GetxController {
  final Rx<XFile> image = XFile("").obs;
  RxInt num = RxInt(0);
  RxList userdata = RxList([]);
  var databse = FirebaseFirestore.instance;

  void onInit() {
    super.onInit();
    fetchUser();
  }

  add() {
    num += 1;
  }

  remove() {
    if (num < 1) {
      return;
    }
    num -= 1;
  }

  fetchUser() async {
    // var data = await databse.collection("users").doc().get();
    // userdata.add(data.data());
    // print("23124 ${data.data()}");
    databse.collection("users").get().then(
      (res) => print("Successfully completed ${res}"),
      onError: (e) => print("Error completing: $e"),
    );
  }
}
