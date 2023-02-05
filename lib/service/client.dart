import 'dart:convert';
import 'package:http/http.dart' as http;

class DbBase {
  var postRequestType = "POST";
  var getRequestType = "GET";
  var patchRequestType = "PATCH";
  var deleteRequestType = "DELETE";

  databaseRequest(String link, String type,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      print(link);
      headers ??= {'Content-Type': 'application/json'};

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
