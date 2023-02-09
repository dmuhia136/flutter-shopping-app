import 'dart:convert';
import 'package:sales_app/functions/function.dart';
import 'package:sales_app/service/apiUrl.dart';
import 'package:sales_app/service/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserClient {
  static loginUser(Map<String, dynamic> userdata) async {
    var response = await DbBase()
        .databaseRequest(login, DbBase().postRequestType, body: userdata);
    var data = jsonDecode(response);
    print("iy data ${data['body']}");

    return data;
  }

  static fetchUser() async {
    final String? id = await Functions().userId();
    print(userid + "/${id}");
    var response = await DbBase()
        .databaseRequest(userid + "/$id", DbBase().getRequestType);
    var data = jsonDecode(response);

    print("iyuuuu data ${data['body']}");

    return data;
  }

  static createUser(Map<String, dynamic> user) async {
    var response = await DbBase()
        .databaseRequest(signup, DbBase().postRequestType, body: user);
   var data = jsonDecode(response);
    print("iy data ${data}");
    return data;
  }

    static uploadUserImage(Map<String, dynamic> image) async {
    final String? id = await Functions().userId();
    var response = await DbBase()
        .databaseRequest(userid +"/image/$id", DbBase().patchRequestType, body: image);
   var data = jsonDecode(response);
    print("iy data ${data}");
    return data;
  }
}
