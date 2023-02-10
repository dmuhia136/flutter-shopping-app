import 'package:sales_app/models/product.dart';
import 'package:sales_app/models/user.dart';

class ShopModel {
  String? sId;
  String? name;
  UserModel? owner;
  String? location;
  int? iV;

  ShopModel({this.sId, this.name, this.owner, this.iV, this.location});

  ShopModel.fromJson(Map<String, dynamic> json) {
    sId:
    json['_id'];
    name:
    json['name'];
    location:
    json['location'];
    owner:
    json['owner'] == null || json['onwer'].toString().length < 40
        ? null
        : UserModel.fromJson(json['owner']);
    iV:
    json['__v'];
  }
}
