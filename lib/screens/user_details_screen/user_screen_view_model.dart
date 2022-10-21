import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/model/user_model.dart';
import 'package:look_prior/screens/change_password_screen/change_password_screen.dart';
import 'package:look_prior/screens/login_screen/login_screen.dart';
import 'package:look_prior/screens/user_details_screen/user_details_screen.dart';
import 'package:look_prior/service/auth_service.dart';
import 'package:look_prior/utils/share_preference.dart';
import 'package:look_prior/utils/single_tone.dart';

import '../../service/rest_service.dart';

class UserScreenViewModel {
  String? token;

  UserDetailScreenState userDetailScreenState;

  UserScreenViewModel(this.userDetailScreenState) {
    token = Singleton.accessToken;
    getProfileData();
  }

  bool status = false;
  Future<UserModel?> getProfileData() async {
    try {
      status = true;
      userDetailScreenState.refresh();
      String? getProfileResponse = await RestServiceConstants.getRestMethods(
          endPoint: RestServiceConstants.getProfileApi, token: token);

      if (getProfileResponse != null && getProfileResponse.isNotEmpty) {
        Map<String, dynamic> userMap = jsonDecode(getProfileResponse);
        if (userMap.containsKey('Success') && userMap['Success']) {
          userDetailScreenState.userModel =
              userModelFromJson(getProfileResponse);
          log("userDetailScreenState.userModel---->${userDetailScreenState.userModel!.email}");

          status = false;
          userDetailScreenState.refresh();
        }
      }
    } on SocketException catch (e) {
      appToast(e.message);
      status = false;
      userDetailScreenState.refresh();
    }
    return null;
  }

  changePasswordOnTap(BuildContext context) async {
    Navigator.pop(context);
    await Future.delayed(const Duration(milliseconds: 180));
    if (userDetailScreenState.mounted) {
      Navigator.push(
          context, CustomRoutes(child: const ChangePasswordScreen()));
    }
  }

  Future<void> logoutOnTap() async {
    Navigator.pop(userDetailScreenState.context);
    try {
      status = true;
      userDetailScreenState.refresh();
      num? uid = Singleton.uid;
      String? logoutResponse =
          await RestServiceConstants.postRestMethodWithParameter(
              endPoint: RestServiceConstants.logOutApi,
              parameter: 'userId=2$uid');

      if (logoutResponse != null && logoutResponse.isNotEmpty) {
        Map<String, dynamic> logoutResponseMap = jsonDecode(logoutResponse);

        if (logoutResponseMap.containsKey('Success') &&
            logoutResponseMap['Success']) {
          appToast(logoutResponseMap['Message']);
          if (userDetailScreenState.mounted) {
            removePrefValue(isLogin);
            removePrefValue(accessToken);
            removePrefValue(userId);
            AuthService().signOutWithGoogle();
            status = false;
            userDetailScreenState.refresh();
            Navigator.pushAndRemoveUntil(userDetailScreenState.context,
                CustomRoutes(child: const LogInScreen()), (route) => false);
          }
        } else {
          status = false;
          userDetailScreenState.refresh();
          appToast(logoutResponseMap['Message']);
        }
      }

      log("logoutResponse---->$logoutResponse");
    } on SocketException catch (e) {
      status = false;
      userDetailScreenState.refresh();
      appToast(e.message);
      log("catch exception for logoutOnTap---->${e.message}");
    }
  }
}
