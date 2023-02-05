import 'dart:convert';

import 'package:sales_app/service/apiUrl.dart';
import 'package:sales_app/service/client.dart';

class ProductClient {
  static fetchProducts() async {
    var response =
        await DbBase().databaseRequest(product, DbBase().getRequestType);
    var data = jsonDecode(response);
    print(data);
    return data['body'];
  }
}
