import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:look_prior/common/widgets/app_snackbar.dart';
import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:look_prior/screens/login_screen/login_screen.dart';
import 'package:look_prior/service/rest_service.dart';

class ForgotPassViewModel {
  ForgotPassScreenState forgotPassScreenState;

  ForgotPassViewModel(this.forgotPassScreenState);

  TextEditingController emailController = TextEditingController();
  bool error = false;
  bool status = false;

  forgotPassOnTap(BuildContext context) {
    error = true;
    if (emailController.text != "") {
      FocusManager.instance.primaryFocus?.unfocus();
      error = false;
      sendRequestInApi(context);
    }
    forgotPassScreenState.refresh();
  }

  Future<void> sendRequestInApi(BuildContext context) async {
    try {
      status = true;
      forgotPassScreenState.refresh();
      String email = emailController.text.trim();

      String? forgotPassResponse =
          await RestServiceConstants.postRestMethodWithParameter(
              endPoint: RestServiceConstants.forgotPassApi,
              parameter: "emailId=$email");

      if (forgotPassResponse != null && forgotPassResponse.isNotEmpty) {
        Map<String, dynamic> forgotPassResponseMap =
            jsonDecode(forgotPassResponse);
        if (forgotPassResponseMap.containsKey('Success') &&
            forgotPassResponseMap['Success']) {
          status = false;
          forgotPassScreenState.refresh();
          if (forgotPassScreenState.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(appSnackBar(
              forgotPassResponseMap['Message'],
              lable: "OK",
              onTap: () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                await Future.delayed(const Duration(milliseconds: 250));
                if (forgotPassScreenState.mounted) {
                  Navigator.pop(context);
                }
              },
            ));
          }
        } else {
          status = false;
          forgotPassScreenState.refresh();
          if (forgotPassScreenState.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(appSnackBar(
              forgotPassResponseMap['Message'],
              lable: "OK",
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ));
          }
        }
      }
    } on ClientException catch (e) {
      appToast(e.message);
      status = false;
      forgotPassScreenState.refresh();
    }
  }
}
