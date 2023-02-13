import 'dart:convert';

import 'package:sales_app/functions/function.dart';
import 'package:sales_app/service/apiUrl.dart';
import 'package:sales_app/service/client.dart';

class ProductClient {
  static fetchProducts() async {
    var response =
        await DbBase().databaseRequest(product, DbBase().getRequestType);
    var data = jsonDecode(response);
    return data;
  }

  static fetchByCategory(String id) async {
    var response = await DbBase()
        .databaseRequest(product + "/category/$id", DbBase().getRequestType);
    var data = jsonDecode(response);
    return data['body'];
  }

  static createProduct(Map<String, dynamic> products) async {
    var response = await DbBase().databaseRequest(
        '$product/create', DbBase().postRequestType,
        body: products);
    var data = jsonDecode(response);
    return data;
  }

  
}
