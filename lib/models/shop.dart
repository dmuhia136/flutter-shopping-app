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
    owner = json['owner'] != null ? null : UserModel.fromJson(json['owner']);
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['location'] = this.location;
    data['owner'] = this.owner;
    data['__v'] = this.iV;
    return data;
  }
}
