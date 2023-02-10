import 'package:sales_app/models/category.dart';
import 'package:sales_app/models/user.dart';

class ProductModel {
  String? sId;
  String? name;
  int? price;
  String? description;
  String? count;
  UserModel? owner;
  CategoryModel? category;
  int? productCount;
  int? productTotal;
  String? imageurl;
  ProductModel(
      {this.count,
      this.description,
      this.name,
      this.owner,
      this.price,
      this.sId,
      this.category,
      this.productCount,
      this.productTotal,
      this.imageurl});

  ProductModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    description = json['description'];
    name = json['name'];
    imageurl = json['imageurl'];
    owner = json['owner'] == null || json['owner'].toString().length <= 40
        ? null
        : UserModel.fromJson(json['owner']);
    category =
        json['category'] == null || json['category'].toString().length <= 40
            ? null
            : CategoryModel.fromJson(json['category']);
    // owner = json['owner'] ;
    sId = json['_id'];
    price = json['price'];
  }
}
