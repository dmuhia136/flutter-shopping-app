import 'package:sales_app/models/shop.dart';

class UserModel {
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? sId;
  String? profileimage;
  int? iV;
  ShopModel? shop;

  UserModel(
      {this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.sId,
      this.profileimage,
      this.shop,
      this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    sId = json['_id'];
    shop:
    json['shop'] == null || json['shop'].toString().length <= 40
        ? null
        : ShopModel.fromJson(json['shop']);
    profileimage = json['profileimage'];
    iV = json['__v'];
  }
}
