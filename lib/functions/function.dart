import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Functions {
  userId() async {
    final prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('userid');
    return id;
  }

  uploadImage(String url, String name) async {
    try {
      final _firebaseStorage = FirebaseStorage.instance;
      var file = File(url);
      if (file != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('images/$name')
            .putFile(file)
            .whenComplete(() => null);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        print("url da aaaa $downloadUrl");

        Fluttertoast.showToast(
            msg: "Image uploaded",
            backgroundColor: Colors.green,
            textColor: Colors.black);
        return downloadUrl;
      } else {
        Fluttertoast.showToast(
            msg: "Image upload failed",
            backgroundColor: Colors.red,
            textColor: Colors.white);

        print('No Image Path Received');
      }
    } catch (e) {}
  }


  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    DateTime notificationDate =
        DateFormat("dd-MM-yyyy h:mma").parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1w ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1d ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours}h ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1h ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes}mins ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1mins ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }


readDate(Timestamp dateTime) {
    DateTime date = DateTime.parse(dateTime.toDate().toString());
    // add DateFormat What you want. Look at the below comment example 
    //String formatedDate = DateFormat('dd-MMM-yyy').format(date); 
    String formatedDate = DateFormat.yMMMMd().format(date);
    return formatedDate;
  }
}
