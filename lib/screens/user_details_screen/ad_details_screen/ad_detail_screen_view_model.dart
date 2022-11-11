import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/model/get_ad_brodcast_detail_model.dart';
import 'package:look_prior/screens/manage_screen/screens.dart';
import 'package:look_prior/service/rest_service.dart';
import 'package:look_prior/utils/single_tone.dart';

import 'ad_details_screen.dart';

class FullAdDetailViewModel {
  FullAdDetailScreenState detailScreenState;

  FullAdDetailViewModel(this.detailScreenState) {
    getBrodCastDetailData();
  }

  bool isLoading = false;
  bool isLoadingDelete = false;
  List<Map<String, dynamic>> allVideoAndImage = [];
  bool isCheck1 = false;
  bool isCheck2 = false;
  int cnt = 0;
  Future<void> getBrodCastDetailData() async {
    String? token = Singleton.accessToken;
    log("brodcasrt id--->${detailScreenState.widget.broadCastId}");
    try {
      isLoading = true;
      detailScreenState.refresh();
      String? brodCastResponse = await RestServiceConstants.getRestMethods(
          endPoint:
              "${RestServiceConstants.getBroadcastDetailApi}?broadCastId=${detailScreenState.widget.broadCastId}&res=true",
          token: token);
      log("brodCastResponse---->${brodCastResponse.toString()}");

      if (brodCastResponse != null && brodCastResponse.isNotEmpty) {
        Map<String, dynamic> brodCastResponseMap = jsonDecode(brodCastResponse);
        if (brodCastResponseMap.containsKey('Success') &&
            brodCastResponseMap['Success']) {
          isLoading = false;
          detailScreenState.refresh();
          detailScreenState.broadcastDetailModel =
              getBroadcastDetailModelFromJson(brodCastResponse);
          log("GetBroadcastDetailModel----->${detailScreenState.broadcastDetailModel!.toJson()}");

          for (int i = 0;
              i < detailScreenState.broadcastDetailModel!.adVideo!.length;
              i++) {
            allVideoAndImage.add({
              "video":
                  "${detailScreenState.broadcastDetailModel!.adVideo![i].videoThumb}"
            });
            log("allVideoAndImage(video)--->$allVideoAndImage");
          }
          for (int i = 0;
              i < detailScreenState.broadcastDetailModel!.adImage!.length;
              i++) {
            allVideoAndImage.add({
              'image':
                  '${detailScreenState.broadcastDetailModel!.adImage![i].adImageThumb}'
            });
            log("allVideoAndImage(Image)--->$allVideoAndImage");
          }
        } else {
          isLoading = false;
          detailScreenState.refresh();
          appToast(brodCastResponseMap['Message']);
        }
      } else {
        isLoading = false;
        detailScreenState.refresh();
        appToast("Network required");
      }
    } on SocketException catch (e) {
      appToast(e.message);
    }
  }

  removeButtonOnTap() {
    if (isCheck1 == false && isCheck2 == false) {
      appToast("Please select one reason");
    } else {
      Navigator.pop(detailScreenState.context);
      deleteAdByAdmin();
    }
  }

  Future<void> deleteAdByAdmin() async {
    num? detailId = detailScreenState.broadcastDetailModel!.addDetailId;
    try {
      isLoadingDelete = true;
      detailScreenState.refresh();
      String? deleteAdByAdminResponse =
          await RestServiceConstants.getRestMethodWithoutToken(
              endPoint:
                  "${RestServiceConstants.getDeleteAdApi}?addDetailId=$detailId");
      log("deleteAdByAdminResponse--->$deleteAdByAdminResponse");
      if (deleteAdByAdminResponse != null &&
          deleteAdByAdminResponse.isNotEmpty) {
        Map<String, dynamic> deleteAdByAdminResponseMap =
            jsonDecode(deleteAdByAdminResponse);

        if (deleteAdByAdminResponseMap.containsKey('Success') &&
            deleteAdByAdminResponseMap['Success']) {
          isLoadingDelete = false;
          detailScreenState.refresh();
          appToast(deleteAdByAdminResponseMap['Message']);

          if (detailScreenState.mounted) {
            Navigator.pushAndRemoveUntil(
                detailScreenState.context,
                CustomRoutes(
                    child: const Screens(
                  index: 3,
                )),
                (route) => false);
          }
        } else {
          isLoadingDelete = false;
          detailScreenState.refresh();
          appToast(deleteAdByAdminResponseMap['Message']);
        }
      }
    } on SocketException catch (e) {
      isLoadingDelete = false;
      detailScreenState.refresh();
      appToast(e.message);
    }
  }
}
