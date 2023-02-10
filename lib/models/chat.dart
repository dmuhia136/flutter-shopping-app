import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String? id;
  final String? Message;
  final int? Time;
  final String? recierverId;
  final String? recieverImg;
  final String? recieverName;
  final String? senderId;
  final String? senderImg;
  final String? senderName;
  final String? sentImg;

  ChatModel(
      {this.Message,
      this.Time,
      this.recierverId,
      this.recieverImg,
      this.recieverName,
      this.senderId,
      this.senderImg,
      this.senderName,
      this.sentImg,
      this.id});

  factory ChatModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return ChatModel(
      id: snapshot.id,
      Message: data?['Message'],
      Time: data?['Time'],
      recierverId: data?['recierverId'],
      recieverImg: data?['recieverImg'],
      recieverName: data?['recieverName'],
      senderId: data?['senderId'],
      senderImg: data?['senderImg'],
      senderName: data?['senderName'],
      sentImg: data?['sentImg'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "_id": id,
      if (Message != null) "Message": Message,
      if (Time != null) "Time": Time,
      if (recierverId != null) "recierverId": recierverId,
      if (recieverImg != null) "recieverImg": recieverImg,
      if (recieverName != null) "recieverName": recieverName,
      if (senderId != null) "senderId": senderId,
      if (senderImg != null) "senderImg": senderImg,
      if (senderName != null) "senderName": senderName,
      if (sentImg != null) "sentImg": sentImg,
    };
  }
}
