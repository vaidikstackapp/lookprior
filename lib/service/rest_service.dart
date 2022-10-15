import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class RestServiceConstants {
  static String? deviceToken;
  static const String baseUrl = "https://lookprstage.com/admin/";
  static const String registerApi = "$baseUrl/api/v1/data/signup";
  static const String signInApi = "$baseUrl/api/v1/data/signin";

  static Map<String, String> headers = {'Content-Type': 'application/json'};

  static dynamic postRestMethods(
      {@required String? endPoint,
      @required Map<String, dynamic>? bodyParam}) async {
    try {
      String url = '$baseUrl$endPoint';

      print("url---->$url");

      Response response = await http.post(Uri.parse(url), body: bodyParam);

      print("response status code------->${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Response body---->${response.body}");
        return response.body;
      }
    } catch (e) {
      print("catch exception for post $endPoint---->$e");
      return null;
    }
  }
}
