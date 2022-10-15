import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/contants/string_contants.dart';
import 'package:look_prior/common/widgets/app_background.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/common/widgets/app_textfield.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/screens/login_screen/login_screen_view_model.dart';
import 'package:look_prior/screens/register_screen/register_screen.dart';
import 'package:look_prior/utils/app_validation.dart';

import '../../common/contants/icon_constants.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
  @override
  void initState() {
    super.initState();
  }

  LogInScreenViewModel? logInScreenViewModel;

  @override
  Widget build(BuildContext context) {
    logInScreenViewModel ?? (logInScreenViewModel = LogInScreenViewModel(this));
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
                  Image.asset(
                    IconConstants.appLogoWithoutColor,
                    height: 60,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                  AppText(
                      text: StringConstants.login,
                      fontSize: 22,
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
                widget: Stack(
                  children: [
                    Form(
                      key: logInScreenViewModel!.logInFormKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                headerText(),
                                subtitleText(),
                                emailTextFiled(context),
                                passwordTextFiled(context),
                                forgotPassword(),
                                loginButton(() =>
                                    logInScreenViewModel!.logInOnTap(context)),
                                divider(),
                                facebookButton(context),
                                appleButton(context),
                                checkAccountRegister(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    (logInScreenViewModel!.status)
                        ? Center(
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              )),
                              child: const Center(
                                  child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator())),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
        controller: logInScreenViewModel!.emailController,
        validator: (value) => AppValidation.loginEmailValidation(value),
        keyboardType: TextInputType.emailAddress,
        hintText: StringConstants.email,
        prefixIcon: IconConstants.mailIcon);
  }

  Widget passwordTextFiled(BuildContext context) {
    return AppTextField(
        topMargin: 15,
        obscureText: true,
        controller: logInScreenViewModel!.passwordController,
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

  Widget loginButton(Function()? loginOnTap) {
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
      child: GestureDetector(
        onTap: () => Navigator.pushReplacement(
            context, CustomRoutes(child: const RegisterScreen())),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: "Don’t have an account? ",
              color: ColorConstants.subTitleColor,
            ),
            AppText(
              text: StringConstants.register,
              color: ColorConstants.headerColor,
            ),
          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
