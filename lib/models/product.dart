import 'package:sales_app/models/category.dart';
import 'package:sales_app/models/user.dart';

class ProductModel {
  String? sId;
  String? name;
  int? price;
  String? imageurl;
  UserModel? owner;
  CategoryModel? category;
  int? iV;

  ProductModel(
      {this.sId,
      this.name,
      this.price,
      this.imageurl,
      this.owner,
      this.category,
      this.iV});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    imageurl = json['imageurl'];
    owner = json['owner'] != null ? new UserModel.fromJson(json['owner']) : null;
    category = json['category'] != null
        ? new CategoryModel.fromJson(json['category'])
        : null;
    iV = json['__v'];
  }

}