import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/contants/string_contants.dart';
import 'package:look_prior/common/widgets/app_background.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/common/widgets/app_textfield.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/screens/home_screen/home_screen.dart';
import 'package:look_prior/screens/register_screen/register_screen.dart';
import 'package:look_prior/utils/app_validation/app_validation.dart';

import '../../common/contants/icon_constants.dart';
import 'dart:convert';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final logInFormKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: 200,
              color: ColorConstants.appColor,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(IconConstants.appLogoWithoutColor),
                  AppText(
                      text: StringConstants.login,
                      fontSize: 26,
                      textAlign: TextAlign.center)
                ],
              ),
            ),
            Positioned(
              top: 170,
              bottom: 0,
              right: 0,
              left: 0,
              child: AppBackRound(
                widget: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Form(
                      key: logInFormKey,
                      child: Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            headerText(),
                            subtitleText(),
                            emailTextFiled(context),
                            passwordTextFiled(context),
                            forgotPassword(),
                            loginButton(
                              context,
                              loginOnTap: () =>
                                  logInOnTap(logInFormKey, context),
                            ),
                            divider(),
                            facebookButton(context),
                            appleButton(context),
                            checkAccountRegister(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logInOnTap(
      GlobalKey<FormState> logInFormKey, BuildContext context) async {
    if (logInFormKey.currentState!.validate()) {
      Navigator.pushReplacement(
          context, CustomRoutes(child: const HomeScreen()));
    }
  }

  Widget headerText() {
    return AppText(
      fontSize: 18,
      textAlign: TextAlign.center,
      text: StringConstants.headerText,
      color: ColorConstants.headerColor,
    );
  }

  Widget subtitleText() {
    return AppText(
      fontSize: 16,
      textAlign: TextAlign.center,
      text: StringConstants.subtitleText,
      color: ColorConstants.subTitleColor,
    );
  }

  Widget emailTextFiled(BuildContext context) {
    return AppTextField(
        topMargin: 15,
        hintTextSize: 13,
        controller: emailController,
        validator: (value) => AppValidation.loginEmailValidation(value),
        keyboardType: TextInputType.emailAddress,
        hintText: StringConstants.email,
        prefixIcon: IconConstants.mailIcon);
  }

  Widget passwordTextFiled(BuildContext context) {
    return AppTextField(
        topMargin: 15,
        obscureText: true,
        controller: passwordController,
        hintTextSize: 13,
        validator: (value) => AppValidation.loginPasswordValidation(value),
        hintText: StringConstants.password,
        prefixIcon: IconConstants.mailIcon);
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.only(right: 18, top: 13),
      child: AppText(
          text: StringConstants.forgotPassword,
          textAlign: TextAlign.end,
          color: ColorConstants.headerColor),
    );
  }

  Widget loginButton(BuildContext context, {Function()? loginOnTap}) {
    return AppButton(
      onTap: loginOnTap,
      text: StringConstants.login,
      buttonColor: ColorConstants.appColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      iconHeight: 19.5,
      iconWidth: 10.48,
      topPadding: 24,
      bottomPadding: 10,
    );
  }

  Widget divider() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 130,
            child: Divider(
              thickness: 1,
              color: ColorConstants.dividerColor.withOpacity(0.2),
            ),
          ),
          AppText(
            text: "Or",
            fontWeight: FontWeight.w400,
            color: ColorConstants.dividerColor.withOpacity(0.5),
          ),
          SizedBox(
            width: 130,
            child: Divider(
              thickness: 1,
              color: ColorConstants.dividerColor.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget facebookButton(BuildContext context) {
    return AppButton(
      text: StringConstants.loginWithFb,
      buttonIcon: IconConstants.facebookIcon,
      buttonColor: ColorConstants.faceBookButtonColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      bottomPadding: 16,
      topPadding: 10,
    );
  }

  Widget appleButton(BuildContext context) {
    return AppButton(
      text: StringConstants.loginWithApple,
      iconWidth: 20.5,
      iconHeight: 18.38,
      buttonIcon: IconConstants.appleIcon,
      buttonColor: ColorConstants.appleButtonColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
  }

  Widget checkAccountRegister(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            text: "Didn’t have an account? ",
            color: ColorConstants.subTitleColor,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context, CustomRoutes(child: const RegisterScreen()));
            },
            child: AppText(
              text: StringConstants.register,
              color: ColorConstants.headerColor,
            ),
          ),
        ],
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);

LogInModel logInModelFromJson(String str) =>
    LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
  LogInModel({
    this.deviceToken,
    this.deviceType,
    this.email,
    this.password,
    this.userName,
    this.facebookProfileUrl,
    this.mobileVersion,
    this.osVersion,
  });

  String? deviceToken;
  String? deviceType;
  String? email;
  String? password;
  String? userName;
  String? facebookProfileUrl;
  String? mobileVersion;
  String? osVersion;

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
        deviceToken: json["devicetoken"],
        deviceType: json["devicetype"],
        email: json["email"],
        password: json["password"],
        userName: json["userName"],
        facebookProfileUrl: json["facebookProfileUrl"],
        mobileVersion: json["mobileVersion"],
        osVersion: json["osVersion"],
      );

  Map<String, dynamic> toJson() => {
        "devicetoken": deviceToken,
        "devicetype": deviceType,
        "email": email,
        "password": password,
        "userName": userName,
        "facebookProfileUrl": facebookProfileUrl,
        "mobileVersion": mobileVersion,
        "osVersion": osVersion,
      };
}
