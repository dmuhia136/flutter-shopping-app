import 'package:sales_app/models/user.dart';

class ProductModel {
  String? sId;
  String? name;
  int? price;
  String? description;
  int? count;
  UserModel? owner;

  ProductModel(
      {this.count,
      this.description,
      this.name,
      this.owner,
      this.price,
      this.sId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    description = json['description'];
    name = json['name'];
    owner = json['owner'] == null ? null : UserModel.fromJson(json['owner']);
    sId = json['_id'];
    price = json['price'];
  }
}
