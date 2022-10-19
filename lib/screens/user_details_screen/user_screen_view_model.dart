import 'dart:convert';
import 'dart:io';

import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/model/user_model.dart';
import 'package:look_prior/screens/user_details_screen/user_details_screen.dart';
import 'package:look_prior/utils/single_tone.dart';

import '../../service/rest_service.dart';

class UserScreenViewModel {
  String? token;

  UserDetailScreenState? userDetailScreenState;

  UserScreenViewModel(this.userDetailScreenState) {
    token = Singleton.accessToken;
    getProfileData();
  }
  UserModel? userModel;
  Future<UserModel?> getProfileData() async {
    try {
      String? getProfileResponse = await RestServiceConstants.getRestMethods(
          endPoint: RestServiceConstants.getProfileApi, token: token);

      if (getProfileResponse != null && getProfileResponse.isNotEmpty) {
        Map<String, dynamic> userMap = jsonDecode(getProfileResponse);
        if (userMap.containsKey('Success') && userMap['Success']) {
          userModel = userModelFromJson(getProfileResponse);
          print("userModel----->${userModel.toString()}");
          return userModel;
        }
      }
    } on SocketException catch (e) {
      appToast(e.message);
    }
    return null;
  }
}
