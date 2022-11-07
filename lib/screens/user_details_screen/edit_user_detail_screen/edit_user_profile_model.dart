import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/model/update_profile_model.dart';
import 'package:look_prior/screens/manage_screen/screens.dart';
import 'package:look_prior/service/rest_service.dart';
import 'package:look_prior/utils/single_tone.dart';

import 'edit_user_detail_screen.dart';

class EditUserModel {
  EditUserDetailScreenState editUserDetailScreenState;

  EditUserModel(this.editUserDetailScreenState) {
    firstNameController.text =
        (editUserDetailScreenState.widget.userModel!.userName == null)
            ? ""
            : editUserDetailScreenState.widget.userModel!.userName.toString();
    lastNameController.text =
        (editUserDetailScreenState.widget.userModel!.lastName == null)
            ? ""
            : editUserDetailScreenState.widget.userModel!.lastName.toString();
    emailController.text =
        (editUserDetailScreenState.widget.userModel!.email == null)
            ? ""
            : editUserDetailScreenState.widget.userModel!.email.toString();
    addressController.text =
        (editUserDetailScreenState.widget.userModel!.fullAddress == null)
            ? ""
            : editUserDetailScreenState.widget.userModel!.fullAddress
                .toString();
    websiteController.text =
        (editUserDetailScreenState.widget.userModel!.website == null)
            ? ""
            : editUserDetailScreenState.widget.userModel!.website.toString();
    phoneController.text =
        (editUserDetailScreenState.widget.userModel!.phoneNumber == null)
            ? ""
            : editUserDetailScreenState.widget.userModel!.phoneNumber
                .toString();

    String countryCode =
        (editUserDetailScreenState.widget.userModel!.countryCode == null)
            ? "91"
            : editUserDetailScreenState.widget.userModel!.countryCode
                .toString();
    country = CountryPickerUtils.getCountryByPhoneCode(countryCode);

    editUserDetailScreenState.widget.userModel!.countryCode;
    isPublicProfile = editUserDetailScreenState.widget.userModel!.publicProfile;

    isPublicEmail =
        editUserDetailScreenState.widget.userModel!.isEmailFieldDisabled;

    useType = editUserDetailScreenState.widget.userModel!.userTypeId!.toInt();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Country country = CountryPickerUtils.getCountryByPhoneCode('1');
  bool isPublicProfile = false;
  bool isPublicEmail = false;

  num useType = 1;
  bool isLoading = false;

  Future<void> saveOnTap() async {
    try {
      isLoading = true;
      editUserDetailScreenState.refresh();
      Map<String, dynamic> setDataInApi = {
        "firstName": (firstNameController.text.trim().isEmpty)
            ? editUserDetailScreenState.widget.userModel!.userName
            : firstNameController.text.trim(),
        "lastName": (lastNameController.text.trim().isEmpty)
            ? editUserDetailScreenState.widget.userModel!.lastName
            : lastNameController.text.trim(),
        "email": editUserDetailScreenState.widget.userModel!.email.toString(),
        "userTypeId": useType,
        "businessName": useType,
        "website": (websiteController.text.trim().isEmpty)
            ? editUserDetailScreenState.widget.userModel!.website
            : websiteController.text.trim(),
        "phoneNumber": (phoneController.text.trim().isEmpty)
            ? editUserDetailScreenState.widget.userModel!.phoneNumber
            : phoneController.text.trim(),
        "publicProfile": isPublicProfile,
        "fullAddress": addressController.text.trim().isEmpty
            ? editUserDetailScreenState.widget.userModel!.fullAddress
            : addressController.text.trim(),
        "ispublicemail": isPublicEmail,
        "countryCode": country.phoneCode,
        "latitude": 21.1702401,
        "longitude": 72.8310607
      };

      String? updateProfileResponse =
          await RestServiceConstants.postRestMethods(
              endPoint: RestServiceConstants.updateProfileApi,
              bodyParam: setDataInApi,
              token: Singleton.accessToken);
      if (updateProfileResponse != null && updateProfileResponse.isNotEmpty) {
        Map<String, dynamic> updateProResponseBodyMap =
            jsonDecode(updateProfileResponse);
        if (updateProResponseBodyMap.containsKey('Success') &&
            updateProResponseBodyMap['Success']) {
          UpdateProfileModel profileModel =
              updateProfileModelFromJson(updateProfileResponse);
          log("UpdateProfileModel---->${profileModel.toString()}");
          appToast(profileModel.message);
          if (editUserDetailScreenState.mounted) {
            Navigator.pushAndRemoveUntil(
                editUserDetailScreenState.context,
                CustomRoutes(
                    child: const Screens(
                  index: 3,
                )),
                (route) => false);
          }
        } else {
          appToast(updateProResponseBodyMap['Message']);
          isLoading = false;
          editUserDetailScreenState.refresh();
        }
      } else {
        appToast("Internet required");
        isLoading = false;
        editUserDetailScreenState.refresh();
      }
      log("updateProfileResponse---->$updateProfileResponse");
    } on SocketException catch (e) {
      log("catch exception for saveOnTap---->${e.message}");
      appToast(e.message);
      isLoading = false;
      editUserDetailScreenState.refresh();
    }
  }
}
