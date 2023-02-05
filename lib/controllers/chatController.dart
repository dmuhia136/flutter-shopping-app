import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  TextEditingController messageController = TextEditingController();
  var database = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final storage = FirebaseStorage.instance;
  Rx<XFile> image = XFile("").obs;
  final ImagePicker picker = ImagePicker();

  void onInit() {
    super.onInit();
    fetchMessages();
  }

  createMessage() async {
    final path = 'images/${image.value.name}';
    final file = File(image.value.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    print(ref.getDownloadURL());
    // UploadTask uploadTask = ref.putFile(file);
    // final snapshot = await uploadTask.whenComplete(() {});
    // final downloadUrl = await snapshot.ref.getDownloadURL();
    // print(downloadUrl);
    // Map<String, dynamic> chat = {
    //   "Sender": user!.uid,
    //   "Message": messageController.text,
    //   "Time": DateTime.now().microsecondsSinceEpoch,
    //   "image":imageUrl
    // };
    // var message = await database
    //     .collection("Messages")
    //     .doc(user!.uid)
    //     .collection("mychats")
    //     .doc()
    //     .set(chat)
    //     .onError((e, _) => print("Error writing document: $e"));

    // messageController.clear();
  }

  fetchMessages() async {
    DocumentReference<Map<String, dynamic>> data =
        await database.collection("Messages").doc(user!.uid);
    // .collection("mychats")
    // .doc();

    data.get().then(
      (DocumentSnapshot doc) {
        final data1 = doc.data() as Map<String, dynamic>;
        // ...
        print("dasddsad,${data1}");
      },
      onError: (e) => print("Error getting document: $e"),
    );
    print("all messages here ${data}");
  }
}
