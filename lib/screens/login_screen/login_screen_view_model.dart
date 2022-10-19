import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/model/facebook_model.dart';
import 'package:look_prior/model/login_model.dart';
import 'package:look_prior/screens/forgot_password_screen/forgot_password_screen.dart';
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
    FocusManager.instance.primaryFocus?.unfocus();
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
          setPrefStringValue(uid, '${logInModel.userId}');
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
    } on SocketException catch (e) {
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
    try {
      status = true;
      logInScreenState.refresh();
      final credential = await authService.signInWithGoogle();
      if (credential != null) {
        log("credential----->${credential.toString()}");

        Map<String, dynamic> googleData = {
          'devicetoken': RestServiceConstants.deviceToken,
          'devicetype': (Platform.isAndroid) ? 1 : 2,
          'email': credential.email,
          'googleId': credential.id,
          'userName': credential.displayName,
          'facebookProfileUrl': credential.photoUrl,
          'mobileVersion': (Platform.isAndroid) ? "Android" : "IOS",
          'osVersion': Platform.operatingSystemVersion,
          'ViaSocial': 2
        };

        String? googleResponse = await RestServiceConstants.postRestMethods(
            endPoint: RestServiceConstants.signInApi, bodyParam: googleData);

        if (googleResponse != null && googleResponse.isNotEmpty) {
          Map<String, dynamic> responseMap = jsonDecode(googleResponse);
          if (responseMap.containsKey('Success') && responseMap['Success']) {
            LogInModel logInModel = logInModelFromJson(googleResponse);

            setPrefStringValue(accessToken, '${logInModel.accessToken}');
            setPrefBoolValue(isLogin, true);
            setPrefStringValue(uid, '${logInModel.userId}');
            appToast(logInModel.message);
            if (logInScreenState.mounted) {
              status = false;
              logInScreenState.refresh();
              Navigator.pushAndRemoveUntil(context,
                  CustomRoutes(child: const HomeScreen()), (route) => false);
            }
          } else {
            appToast(responseMap['Message']);
            status = false;
            logInScreenState.refresh();
          }
        }
      }
    } on SocketException catch (e) {
      appToast(e.message);
      status = false;
      logInScreenState.refresh();
    } finally {
      status = false;
      logInScreenState.refresh();
    }
  }

  Future<void> faceBookOnTap(BuildContext context) async {
    try {
      status = true;
      logInScreenState.refresh();
      LoginResult? result = await authService.faceBookLogIn();

      if (result != null) {
        if (result.status == LoginStatus.success) {
          Map<String, dynamic> fbUserData =
              await FacebookAuth.instance.getUserData();
          log("FbUserDAta----->${fbUserData.toString()}");
          FaceBookModel faceBookModel = FaceBookModel.fromJson(fbUserData);

          Map<String, dynamic> fbData = {
            'devicetoken': RestServiceConstants.deviceToken,
            'devicetype': (Platform.isAndroid) ? 1 : 2,
            'email': "ashok.stackapp@gmail.com",
            'fbId': faceBookModel.id,
            'userName': faceBookModel.name,
            'facebookProfileUrl': faceBookModel.picture!.data!.url,
            'mobileVersion': (Platform.isAndroid) ? "Android" : "IOS",
            'osVersion': Platform.operatingSystemVersion,
            'ViaSocial': 1
          };

          String? fbResponse = await RestServiceConstants.postRestMethods(
              endPoint: RestServiceConstants.signInApi, bodyParam: fbData);

          if (fbResponse != null && fbResponse.isNotEmpty) {
            Map<String, dynamic> fbResponseMap = jsonDecode(fbResponse);

            if (fbResponseMap.containsKey('Success') &&
                fbResponseMap['Success']) {
              LogInModel logInModel = logInModelFromJson(fbResponse);

              appToast(logInModel.message);
              setPrefStringValue(accessToken, '${logInModel.accessToken}');
              setPrefBoolValue(isLogin, true);
              setPrefStringValue(uid, '${logInModel.userId}');

              if (logInScreenState.mounted) {
                status = false;
                logInScreenState.refresh();
                Navigator.pushAndRemoveUntil(context,
                    CustomRoutes(child: const HomeScreen()), (route) => false);
              }
            } else {
              status = false;
              logInScreenState.refresh();
              appToast(fbResponseMap['Message']);
            }
          }
        } else {
          status = false;
          logInScreenState.refresh();
          appToast(result.message);
        }
      }
    } on SocketException catch (e) {
      status = false;
      logInScreenState.refresh();
      appToast(e.message);
    }
  }

  Future<void> forgotPasswordOnTap(BuildContext context) async {
    Navigator.push(context, CustomRoutes(child: const ForgotPassScreen()));
  }
}
