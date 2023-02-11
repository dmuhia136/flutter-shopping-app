import 'package:sales_app/models/shop.dart';

class UserModel {
  String? sId;
  String? firstname;
  String? lastname;
  String? profileimage;
  String? email;
  String? password;
  ShopModel? shop;
  int? iV;

  UserModel(
      {this.sId,
      this.firstname,
      this.lastname,
      this.profileimage,
      this.email,
      this.password,
      this.shop,
      this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    profileimage = json['profileimage'];
    email = json['email'];
    password = json['password'];
    shop = json['shop'] != null ? new ShopModel.fromJson(json['shop']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['profileimage'] = this.profileimage;
    data['email'] = this.email;
    data['password'] = this.password;
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}


