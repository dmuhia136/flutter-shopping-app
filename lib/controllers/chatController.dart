import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/functions/function.dart';
import 'package:sales_app/models/chat.dart';

import '../models/user.dart';

class ChatController extends GetxController {
  TextEditingController messageController = TextEditingController();
  AuthController authController = Get.find<AuthController>();
  var database = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final storage = FirebaseStorage.instance;
  Rx<XFile> image = XFile("").obs;
  String imageUrl = "";
  final ImagePicker picker = ImagePicker();
  RxBool isSending = RxBool(false);
  RxList<ChatModel> chatList = RxList<ChatModel>();
  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }

  sendMessage(UserModel? reciever) async {
    try {
      isSending.value = true;
      Map<String, dynamic> chat = {
        "senderId": authController.userData.value!.sId,
        "senderImg": authController.userData.value!.profileimage,
        "senderName":
            "${authController.userData.value!.firstname} ${authController.userData.value!.lastname}",
        "recierverId": reciever!.sId,
        "recieverImg": reciever.profileimage,
        "recieverName": "${reciever.firstname} ${reciever.lastname}",
        "Message": messageController.text,
        "Time": DateTime.now().microsecondsSinceEpoch,
        "sentImg": imageUrl
      };
      print(chat);
      await database
          .collection("Messages")
          .doc(authController.userData.value!.sId)
          .collection("mychats")
          .doc()
          .set(chat)
          .onError((e, _) => print("Error writing document: $e"));

      messageController.clear();
      imageUrl = "";
      Fluttertoast.showToast(
          msg: "Message sent to ${reciever.firstname} ${reciever.lastname}");
      isSending.value = false;
    } catch (e) {
      print(e);
    }
  }

  Future<List<ChatModel>> fetchMessages() async {
    String id = await Functions().userId();
    final snapshot = await database
        .collection("Messages")
        .doc("$id")
        .collection("mychats")
        .get();

    final chatData =
        snapshot.docs.map((e) => ChatModel.fromFirestore(e)).toList();
    chatList.assignAll(
        snapshot.docs.map((e) => ChatModel.fromFirestore(e)).toList());
    print("current data ${chatData}");
    return chatData;
  }
}
