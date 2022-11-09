import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class RestServiceConstants {
  static String? deviceToken;
  static const String baseUrl = "https://lookprstage.com/admin/";
  static const String registerApi = "/api/v1/data/signup";
  static const String signInApi = "/api/v1/data/signin";
  static const String forgotPassApi = "/api/v1/data/forgotpassword";
  static const String getProfileApi = "/api/v1/data/getprofiledetail";
  static const String changePassApi = "/api/v1/data/changepassword";
  static const String logOutApi = "/api/v1/data/logout";
  static const String updateProfileApi = "/api/v1/data/updateprofile";
  static const String postAdDetailApi = "$baseUrl/api/v1/detail/AddOrUpdateAd2";
  static const String getAdDetailApi = "/api/v1/detail/getmyadds";
  static const String getDeleteAdApi = "/api/v1/detail/DeleteAdByAdmin";
  static const String getFilterAdApi = "/api/v1/detail/getfilteredadds";
  static const String getBroadcastDetailApi =
      "/api/v1/detail/getbroadcastdetailnew";

  static Map<String, String> headers = {'Content-Type': 'application/json'};
  final Future<ConnectivityResult> connectivity =
      Connectivity().checkConnectivity();

  static dynamic postRestMethods(
      {@required String? endPoint,
      @required Map<String, dynamic>? bodyParam,
      String? token}) async {
    String? responseData;
    var connected = await (Connectivity().checkConnectivity());

    if (connected != ConnectivityResult.mobile &&
        connected != ConnectivityResult.wifi) {
      return responseData;
    }
    try {
      String url = '$baseUrl$endPoint';

      if (token != null && token.isNotEmpty) {
        headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };
      }
      log("header----->${headers.toString()}");
      log("url---->$url");

      Response response = await http.post(Uri.parse(url),
          body: jsonEncode(bodyParam), headers: headers);

      log("response status code------->${response.statusCode}");

      switch (response.statusCode) {
        case 200:
        case 201:
          responseData = response.body;
          break;
        case 400:
        case 404:
        case 500:
        case 502:
          log("response status code------->${response.statusCode}");
          break;
        case 401:
          log("401---->${response.body}");
          break;
        default:
          log('${response.statusCode} : ${response.body}');
          break;
      }
    } on PlatformException catch (e) {
      log("catch exception for post $endPoint---->${e.message}");
    }
    return responseData;
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

  static dynamic getRestMethods(
      {@required String? endPoint, @required String? token}) async {
    try {
      Map<String, String> header = {'Authorization': 'Bearer $token'};
      String url = "$baseUrl$endPoint";

      log("url---->$url");

      Response response = await http.get(Uri.parse(url), headers: header);
      log("response status code---->${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("response body ----->${response.body}");
        return response.body;
      }
    } catch (e) {
      log("catch exception for getRestMethods $endPoint----->$e");
    }
  }

  static dynamic getRestMethodWithoutToken({@required String? endPoint}) async {
    try {
      String url = "$baseUrl$endPoint";

      log("url---->$url");

      Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("response body ----->${response.body}");
        return response.body;
      }
    } catch (e) {
      log("catch exception for getRestMethodWithoutToken $endPoint----->$e");
    }
  }
}
