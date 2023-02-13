import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DbBase {
  var postRequestType = "POST";
  var getRequestType = "GET";
  var patchRequestType = "PATCH";
  var deleteRequestType = "DELETE";

  databaseRequest(String link, String type,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      print(link);
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      headers ??= {'Content-Type': 'application/json','Bearer': token.toString()};

      var request = http.Request(type, Uri.parse(link));

      print("request ${request.method} ${request.url}");

      if (body != null) {
        request.body = json.encode(body);
        print("body ${request.body}");
      }
      request.headers.addAll(headers);
      print(request.toString());
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 404) {
        print("Error 404");
      }
      return response.stream.bytesToString();
    } catch (e, s) {
      print("Error on api $link $e $s");
    }
  }
}
