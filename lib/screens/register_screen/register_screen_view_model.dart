import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/model/register_model.dart';
import 'package:look_prior/screens/login_screen/login_screen.dart';
import 'package:look_prior/screens/register_screen/register_screen.dart';
import 'package:look_prior/service/rest_service.dart';

class RegisterScreenViewModel {
  RegisterScreenState registerScreenState;
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool status = false;
  Country? country = Country(
      phoneCode: '91',
      countryCode: 'IN',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'India',
      example: '9123456789',
      displayName: 'India (IN) [+91]',
      displayNameNoCountryCode: 'India (IN)',
      e164Key: '91-IN-0');

  final registerKey = GlobalKey<FormState>();

  RegisterScreenViewModel(this.registerScreenState);

  Future<void> registerOnTap(BuildContext context) async {
    if (registerKey.currentState!.validate()) {
      setRegisterDataInApi(context);
    }
  }

  setRegisterDataInApi(BuildContext context) async {
    try {
      status = true;
      registerScreenState.refresh();

      Map<String, dynamic> setRegisterData = {
        'email': emailController.text.trim(),
        'name': userNameController.text.trim(),
        'password': passwordController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
        'countryCode': country!.countryCode,
        'deviceToken': RestServiceConstants.deviceToken,
        'deviceType': (Platform.isAndroid) ? 1 : 2,
      };
      String? registerResponse = await RestServiceConstants.postRestMethods(
          endPoint: RestServiceConstants.registerApi,
          bodyParam: setRegisterData);

      if (registerResponse != null && registerResponse.isNotEmpty) {
        Map<String, dynamic> registerResponseMap = jsonDecode(registerResponse);

        if (registerResponseMap.containsKey('Success') &&
            registerResponseMap['Success']) {
          RegisterModel registerModel = registerModelFromJson(registerResponse);
          log("registerModel---->${registerModel.toJson()}");

          if (registerScreenState.mounted) {
            appToast(registerResponseMap['Message']);
            status = false;
            registerScreenState.refresh();
            Navigator.pushAndRemoveUntil(context,
                CustomRoutes(child: const LogInScreen()), (route) => false);
          }
        } else {
          appToast(registerResponseMap['Message']);
          status = false;
          registerScreenState.refresh();
        }
      }
    } on SocketException catch (e) {
      log("catch exception for setRegisterDataInApi----->${e.message}");
      status = false;
      registerScreenState.refresh();
    }
  }
}
