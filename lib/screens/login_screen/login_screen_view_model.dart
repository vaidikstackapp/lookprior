import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/service/rest_service.dart';

import '../../common/widgets/custom_route.dart';
import '../../utils/share_preference.dart';
import '../home_screen/home_screen.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class LogInScreenViewModel {
  LogInScreenState logInScreenState;

  LogInScreenViewModel(this.logInScreenState);

  final logInFormKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool status = false;

  Future<void> logInOnTap(BuildContext context) async {
    if (logInFormKey.currentState!.validate()) {
      // Navigator.pushReplacement(
      //     context, CustomRoutes(child: const HomeScreen()));
      setLogInData(context);
    }
  }

  Future<void> setLogInData(BuildContext context) async {
    try {
      status = true;
      logInScreenState.refresh();
      Map logInData = {
        'devicetoken': RestServiceConstants.deviceToken,
        'devicetype': "2",
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'userName': "",
        'facebookProfileUrl': "",
        "mobileVersion": "IOS",
        "osVersion": "10.11"
      };

      var url = Uri.parse(RestServiceConstants.signInApi);
      Response response = await http.post(url, body: logInData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("response--------------->${response.body}");

        Map responseBody = jsonDecode(response.body);
        if (responseBody['Success'] == true) {
          appToast("${responseBody['Message']}");
          status = false;
          logInScreenState.refresh();
          setPrefStringValue(accessToken, '${responseBody['access_token']}');
          log("aceesToken------------>${responseBody['access_token']}");
          setPrefBoolValue(isLogin, true);

          if (logInScreenState.mounted) {
            Navigator.pushReplacement(
                context, CustomRoutes(child: const HomeScreen()));
          }
        } else {
          appToast("${responseBody['Message']}");
          status = false;
          logInScreenState.refresh();
        }
        log("body------------->${responseBody['Message']}");
      }
    } on ClientException catch (e) {
      log("Catch exception for setLogInData------------>${e.message}");
      appToast(e.message);
      status = false;
      logInScreenState.refresh();
    } finally {
      status = false;
      logInScreenState.refresh();
    }
  }
}
