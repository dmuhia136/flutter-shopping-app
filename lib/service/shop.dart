import 'dart:convert';

import 'package:sales_app/functions/function.dart';
import 'package:sales_app/service/apiUrl.dart';
import 'package:sales_app/service/client.dart';

class ShopClient {
  static fetchAllShops() async {
    var response =
        await DbBase().databaseRequest(shop, DbBase().getRequestType);
    var data = jsonDecode(response);
    return data['body'];
  }

  static createShops(Map<String, dynamic> shopdata) async {
    var response = await DbBase().databaseRequest(
        "$shop/create", DbBase().postRequestType,
        body: shopdata);
    var data = jsonDecode(response);
    return data;
  }
}
