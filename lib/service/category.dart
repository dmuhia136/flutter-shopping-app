import 'dart:convert';

import 'package:sales_app/service/apiUrl.dart';
import 'package:sales_app/service/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryClient {
  static fetchCategory() async {
    var response =
        await DbBase().databaseRequest(category, DbBase().getRequestType);
    var data = jsonDecode(response);
    return data['body'];
  }

  static createCategory(Map<String, dynamic> cat) async {
    var response = await DbBase().databaseRequest(
        "$category/create", DbBase().postRequestType,
        body: cat);
    var data = jsonDecode(response);
    return data;
  }
}
