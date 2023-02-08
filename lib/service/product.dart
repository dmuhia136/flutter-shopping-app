import 'dart:convert';

import 'package:sales_app/service/apiUrl.dart';
import 'package:sales_app/service/client.dart';

class ProductClient {
  static fetchProducts() async {
    var response =
        await DbBase().databaseRequest(product, DbBase().getRequestType);
    var data = jsonDecode(response);
    print("tdasdas ${data}");
    return data;
  }

  static createProduct(Map<String, dynamic> products) async {
    var response = await DbBase().databaseRequest(
        '$product/create', DbBase().postRequestType,
        body: products);
    var data = jsonDecode(response);
    print("iy data ${data['body']}");
    return data;
  }
}
