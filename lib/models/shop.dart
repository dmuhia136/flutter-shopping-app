import 'package:sales_app/models/product.dart';
import 'package:sales_app/models/user.dart';

class ShopModel {
  String? sId;
  String? name;
  UserModel? owner;
  List<ProductModel>? products;
  int? iV;

  ShopModel({this.sId, this.name, this.owner, this.products, this.iV});

  ShopModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];  
    name = json['name'];
    owner = json['owner'] ?? null;
    products:
    List<ProductModel>.from(
        json["products"].map((item) => ProductModel.fromJson(item)));
    iV = json['__v'];
  }
}
