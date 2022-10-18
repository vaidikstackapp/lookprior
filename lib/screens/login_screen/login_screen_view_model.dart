import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart';
import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/model/login_model.dart';
import 'package:look_prior/service/auth_service.dart';
import 'package:look_prior/service/rest_service.dart';

import '../../common/widgets/custom_route.dart';
import '../../utils/share_preference.dart';
import '../home_screen/home_screen.dart';
import 'login_screen.dart';

class LogInScreenViewModel {
  AuthService authService = AuthService();
  LogInScreenState logInScreenState;

  LogInScreenViewModel(this.logInScreenState);

  final logInFormKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool status = false;

  Future<void> logInOnTap(BuildContext context) async {
    if (logInFormKey.currentState!.validate()) {
      setLogInData(context);
    }
  }

  Future<void> setLogInData(BuildContext context) async {
    try {
      status = true;
      logInScreenState.refresh();
      Map<String, dynamic> logInData = {
        'devicetoken': RestServiceConstants.deviceToken,
        'devicetype': (Platform.isAndroid) ? 1 : 2,
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'userName': "",
        'facebookProfileUrl': "",
        "mobileVersion": (Platform.isAndroid) ? "Android" : "IOS",
        "osVersion": Platform.operatingSystemVersion,
      };

      log("Log in data---->${logInData.toString()}");

      String? logInResponse = await RestServiceConstants.postRestMethods(
          endPoint: RestServiceConstants.signInApi, bodyParam: logInData);
      if (logInResponse != null && logInResponse.isNotEmpty) {
        Map<String, dynamic> logInResponseMap = jsonDecode(logInResponse);

        if (logInResponseMap.containsKey('Success') &&
            logInResponseMap['Success']) {
          LogInModel logInModel = logInModelFromJson(logInResponse);

          log("Log in response------>${logInModel.toJson()}");

          setPrefStringValue(accessToken, '${logInModel.accessToken}');
          setPrefBoolValue(isLogin, true);
          status = false;
          logInScreenState.refresh();
          appToast(logInModel.message);
          if (logInScreenState.mounted) {
            Navigator.pushAndRemoveUntil(context,
                CustomRoutes(child: const HomeScreen()), (route) => false);
          }
        } else {
          status = false;
          logInScreenState.refresh();
          appToast(logInResponseMap['Message']);
        }
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

  Future<void> googleOnTap(BuildContext context) async {
    final credential = await authService.signInWithGoogle();
    if (credential != null) {
      if (logInScreenState.mounted) {
        Navigator.pushAndRemoveUntil(
            context, CustomRoutes(child: const HomeScreen()), (route) => false);
      }
      print("credential----->${credential.toString()}");
    }
  }

  faceBookLogIn(BuildContext context) async {
    try {
      final credential = await FacebookAuth.instance
          .login(permissions: ['email', 'public_profile']);
      print("credential status--->${credential.status}");
      if (credential.status == LoginStatus.success) {
        print("credential----->${credential.toString()}");
      }
    } catch (e) {
      print("exception----->$e");
    }
  }
}
