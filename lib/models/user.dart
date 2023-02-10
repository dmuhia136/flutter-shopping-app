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
        :new ShopModel.fromJson(json['shop']);
    profileimage = json['profileimage'];
    iV = json['__v'];
  }
}

// import 'package:sales_app/models/shop.dart';

// class UserModel {
//   String? sId;
//   String? firstname;
//   String? lastname;
//   String? profileimage;
//   String? email;
//   String? password;
//   ShopModel? shop;
//   int? iV;

//   UserModel(
//       {this.sId,
//       this.firstname,
//       this.lastname,
//       this.profileimage,
//       this.email,
//       this.password,
//       this.shop,
//       this.iV});

//   UserModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     firstname = json['firstname'];
//     lastname = json['lastname'];
//     profileimage = json['profileimage'];
//     email = json['email'];
//     password = json['password'];
//     shop = json['shop'] != null || json['shop'].toString().length <= 40
//         ? ShopModel.fromJson(json['shop'])
//         : null;
//     iV = json['__v'];
//   }
// }
