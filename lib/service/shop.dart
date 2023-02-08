import 'dart:convert';

import 'package:sales_app/service/apiUrl.dart';
import 'package:sales_app/service/client.dart';

class ShopClient {
  static fetchAllShops() async {
    var response =
        await DbBase().databaseRequest(shop, DbBase().getRequestType);

    var data = jsonDecode(response);
    return data['body'];
  }
}
