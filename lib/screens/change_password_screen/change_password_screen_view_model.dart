import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/screens/change_password_screen/change_password_screen.dart';
import 'package:look_prior/service/rest_service.dart';
import 'package:look_prior/utils/single_tone.dart';

class ChangePassViewModel {
  ChangePasswordScreenState passwordScreenState;

  ChangePassViewModel(this.passwordScreenState);

  final passwordKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool status = false;
  void updatePassOnTap(BuildContext context) {
    if (passwordKey.currentState!.validate()) {
      setPassInApi();
    }
  }

  String? oldPassValidation(String? value) {
    if (value == null) {
      return null;
    } else if (value.isEmpty) {
      return "Enter your old password";
    }
    return null;
  }

  String? newPassValidation(String? value) {
    if (value == null) {
      return null;
    } else if (value.isEmpty) {
      return "Enter your new password";
    }
    return null;
  }

  String? confirmPassValidation(String? value) {
    if (value == null) {
      return null;
    } else if (value.isEmpty) {
      return "Enter confirm old password";
    } else if (newPasswordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      return "Enter correct password";
    }
    return null;
  }

  Future<void> setPassInApi() async {
    try {
      status = true;
      passwordScreenState.refresh();
      String? token = Singleton.accessToken;
      Map<String, dynamic> setDataInApi = {
        "oldPassword": oldPasswordController.text.trim(),
        "newPassword": newPasswordController.text.trim(),
      };
      String? changePassResponse = await RestServiceConstants.postRestMethods(
          endPoint: RestServiceConstants.changePassApi,
          token: token,
          bodyParam: setDataInApi);
      log("changePassResponse----->$changePassResponse");

      if (changePassResponse != null && changePassResponse.isNotEmpty) {
        Map<String, dynamic> changePassResponseBody =
            jsonDecode(changePassResponse);

        if (changePassResponseBody.containsKey('Success') &&
            changePassResponseBody['Success']) {
          appToast(changePassResponseBody['Message']);
          log("hello");
          if (passwordScreenState.mounted) {
            Navigator.pop(passwordScreenState.context);
          }
        } else {
          status = false;
          passwordScreenState.refresh();
          appToast(changePassResponseBody['Message']);
        }
      } else {
        appToast("Network required");
        status = false;
        passwordScreenState.refresh();
      }
    } on SocketException catch (e) {
      status = false;
      passwordScreenState.refresh();
      log("Catch Exception for setPassApi---->$e");
    }
  }
}
