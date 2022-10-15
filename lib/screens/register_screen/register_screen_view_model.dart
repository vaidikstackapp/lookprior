import 'dart:convert';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/screens/register_screen/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:look_prior/service/rest_service.dart';

import '../login_screen/login_screen.dart';

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
        'name': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
        'countryCode': country!.countryCode,
        'deviceToken': RestServiceConstants.deviceToken,
        'deviceType': "1",
      };
      Response response = await http.post(
          Uri.parse(RestServiceConstants.registerApi),
          body: setRegisterData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> registerResponse = jsonDecode(response.body);

        if (registerResponse['Success'] == true) {
          status = false;
          registerScreenState.refresh();
          appToast(registerResponse['Message']);
          if (registerScreenState.mounted) {
            Navigator.pushAndRemoveUntil(context,
                CustomRoutes(child: const LogInScreen()), (route) => false);
          }
        } else {
          status = false;
          registerScreenState.refresh();
          appToast(registerResponse['Message']);
        }
      }
    } on SocketException catch (e) {
      print("catch exception for setRegisterDataInApi----->${e.message}");
      status = false;
      registerScreenState.refresh();
    }
  }
}
