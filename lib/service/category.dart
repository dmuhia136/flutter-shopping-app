import 'dart:convert';

import 'package:sales_app/service/apiUrl.dart';
import 'package:sales_app/service/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryClient {
  static fetchCategory() async {
    var response =
        await DbBase().databaseRequest(category, DbBase().getRequestType);
    var data = jsonDecode(response);
    print(data);
    return data['body'];
  }
}
