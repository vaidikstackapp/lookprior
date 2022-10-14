import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/contants/string_contants.dart';
import 'package:look_prior/common/widgets/app_background.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/common/widgets/app_textfield.dart';
import 'package:look_prior/screens/register_screen/register_screen_view_model.dart';
import 'package:look_prior/utils/app_validation/app_validation.dart';

import '../../common/contants/icon_constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenViewModel? registerScreenViewModel;

  @override
  Widget build(BuildContext context) {
    registerScreenViewModel ??
        (registerScreenViewModel = RegisterScreenViewModel(this));

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              color: ColorConstants.appColor,
              width: double.infinity,
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 60,
              child: Container(
                color: ColorConstants.appColor,
                child: Column(
                  children: [
                    Image.asset(
                        height: 56,
                        width: 87,
                        fit: BoxFit.fill,
                        IconConstants.appLogoWithoutColor),
                    AppText(
                      text: 'Register',
                      fontSize: 26,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: 170,
                left: 0,
                right: 0,
                bottom: 0,
                child: AppBackRound(
                  widget: (registerScreenViewModel!.status)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Form(
                          key: registerScreenViewModel!.registerKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    userNameTextField(context),
                                    emailTextFiled(context),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 14),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: countryPicker,
                                            child: showCountry(),
                                          ),
                                          phoneNumberTextField(context),
                                        ],
                                      ),
                                    ),
                                    passwordTextField(),
                                    confirmPasswordTextField(),
                                    registerButton(
                                      registerOnTap: () {
                                        registerScreenViewModel!
                                            .registerOnTap(context);
                                      },
                                    ),
                                    divider(),
                                    facebookButton(),
                                    appleButton(),
                                    privacyPolicy()
                                  ],
                                ),
                              ),
                            ],
                          )),
                )),
          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  //----------------Username textFiled---------------

  Widget userNameTextField(BuildContext context) {
    return AppTextField(
        hintTextSize: 13,
        controller: registerScreenViewModel!.userNameController,
        validator: (value) => AppValidation.usernameValidation(value),
        hintText: StringConstants.name,
        prefixIcon: IconConstants.userIcon);
  }

//----------------Email textFiled---------------

  Widget emailTextFiled(BuildContext context) {
    return AppTextField(
        topMargin: 15,
        controller: registerScreenViewModel!.emailController,
        validator: (value) => AppValidation.registerEmailValidation(value),
        hintTextSize: 13,
        keyboardType: TextInputType.emailAddress,
        hintText: StringConstants.email,
        prefixIcon: IconConstants.mailIcon);
  }

//----------------PhoneNumber textFiled---------------

  Widget phoneNumberTextField(BuildContext context) {
    return Expanded(
      //flex: 2,
      child: AppTextField(
        controller: registerScreenViewModel!.phoneController,
        validator: (value) => AppValidation.phoneValidation(value),
        keyboardType: TextInputType.phone,
        prefixIcon: IconConstants.phoneIcon,
        hintText: "Phone number (opt)",
        hintTextSize: 13,
      ),
    );
  }

//----------------Password textFiled---------------

  Widget passwordTextField() {
    return AppTextField(
      topMargin: 15,
      controller: registerScreenViewModel!.passwordController,
      obscureText: true,
      validator: (value) => AppValidation.registerPasswordValidation(value),
      prefixIcon: IconConstants.lockIcon,
      hintTextSize: 13,
      hintText: StringConstants.password,
    );
  }

//----------------Confirm password textFiled---------------

  Widget confirmPasswordTextField() {
    return AppTextField(
      controller: registerScreenViewModel!.confirmPasswordController,
      topMargin: 15,
      obscureText: true,
      validator: (value) => AppValidation.confirmPasswordValidation(
          value, registerScreenViewModel!.passwordController.text),
      prefixIcon: IconConstants.lockIcon,
      hintTextSize: 13,
      hintText: StringConstants.confirmPassword,
    );
  }

  //-----------------Country Picker-------------------

  countryPicker() {
    showCountryPicker(
      context: context,
      exclude: <String>['KN', 'MF'],
      favorite: <String>['SE'],
      showPhoneCode: true,
      onSelect: (val) {
        registerScreenViewModel!.country = val;
        setState(() {});
      },
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
    );
  }

//----------------------Show Country--------------------

  Widget showCountry() {
    return Card(
      child: Container(
          height: 50,
          width: 120,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppText(
                  text: registerScreenViewModel!.country!.flagEmoji,
                  fontSize: 20,
                ),
                AppText(
                  text: "(${registerScreenViewModel!.country!.countryCode})",
                  fontSize: 12,
                  color: Colors.black,
                ),
                AppText(
                  text: "+${registerScreenViewModel!.country!.phoneCode}",
                  fontSize: 12,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: SvgPicture.asset(IconConstants.dropDownIcon),
                ),
              ],
            ),
          )),
    );
  }

  //-----------------Register button--------------

  Widget registerButton({Function()? registerOnTap}) {
    return AppButton(
      onTap: registerOnTap,
      text: StringConstants.register,
      buttonColor: ColorConstants.appColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      iconHeight: 19.5,
      iconWidth: 10.48,
      topPadding: 24,
      bottomPadding: 10,
    );
  }

  //-------------------Facebook button--------------

  Widget facebookButton() {
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

  //----------------Apple button--------------
  Widget appleButton() {
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

  //--------------Divider-----------------------

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

//-----------------------privacyPolicy------------------

  Widget privacyPolicy() {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 15, top: 19, bottom: 19),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              fontSize: 11,
              textAlign: TextAlign.center,
              color: ColorConstants.dividerColor,
              text: StringConstants.privacy,
            ),
          )
        ],
      ),
    );
  }
}
