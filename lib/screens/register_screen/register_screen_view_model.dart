import 'dart:convert';
import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/model/register_model.dart';
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
      // setDataInApi(context);
    }
  }

  setDataInApi(BuildContext context) async {
    try {
      status = true;
      registerScreenState.refresh();
      String uri = RestServiceConstants.registerApi;

      RegisterModel model = RegisterModel(
          deviceToken: RestServiceConstants.deviceToken,
          phoneNumber: phoneController.text.trim(),
          countryCode: country!.countryCode.trim(),
          name: userNameController.text.trim(),
          deviceType: "1",
          password: passwordController.text.trim(),
          email: emailController.text.trim());

      var url = Uri.parse(uri);
      Response response = await http.post(url, body: model.toJson());
      print("response code------------>${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("response------------>${response.body}");
        Map m = jsonDecode(response.body);
        if (m['Success'] == true) {
          if (registerScreenState.mounted) {
            Navigator.pushReplacement(
                context, CustomRoutes(child: const LogInScreen()));
          }
        } else {
          status = false;
          registerScreenState.refresh();
          appToast(m['Message']);
        }
      }
    } on ClientException catch (e) {
      log("Catch exception for setDataInApi--------------->${e.uri}");
      appToast(e.message);
      status = false;
      registerScreenState.refresh();
    } finally {
      status = false;
      registerScreenState.refresh();
    }
  }
}
