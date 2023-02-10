import 'package:sales_app/models/user.dart';

class ShopModel {
  String? sId;
  String? name;
  String? location;
  UserModel? owner;
  int? iV;

  ShopModel({this.sId, this.name, this.location, this.owner, this.iV});

  ShopModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    location = json['location'];
    owner = json['owner'] != null || json['owner'].toString().length <= 40
        ? UserModel.fromJson(json['owner'])
        : null;
    iV = json['__v'];
  }
}
