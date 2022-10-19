import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class RestServiceConstants {
  static String? deviceToken;
  static const String baseUrl = "https://lookprstage.com/admin/";
  static const String registerApi = "/api/v1/data/signup";
  static const String signInApi = "/api/v1/data/signin";
  static const String forgotPassApi = "/api/v1/data/forgotpassword";

  static Map<String, String> headers = {'Content-Type': 'application/json'};

  static dynamic postRestMethods(
      {@required String? endPoint,
      @required Map<String, dynamic>? bodyParam}) async {
    try {
      String url = '$baseUrl$endPoint';

      log("url---->$url");

      Response response = await http.post(Uri.parse(url),
          body: jsonEncode(bodyParam), headers: headers);

      log("response status code------->${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Response body---->${response.body}");
        return response.body;
      }
    } catch (e) {
      log("catch exception for post $endPoint---->$e");
      return null;
    }
  }

  static dynamic postRestMethodWithParameter(
      {@required String? endPoint, @required String? parameter}) async {
    try {
      String url = "$baseUrl$endPoint?$parameter";

      log("url------>$url");

      Response response = await http.post(Uri.parse(url), headers: headers);
      log("status code---->${response.statusCode}");

      if (response.statusCode == 200) {
        log("body---->${response.body}");
        return response.body;
      }
    } on Exception catch (e) {
      log("catch exception for post $endPoint----->$e");
      return null;
    }
  }
}
