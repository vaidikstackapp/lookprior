import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/model/get_filtered_ads.dart';
import 'package:look_prior/service/rest_service.dart';
import 'package:look_prior/utils/single_tone.dart';

import 'home_screen.dart';

class HomeScreenViewModel {
  HomeScreenState homeScreenState;

  HomeScreenViewModel(this.homeScreenState) {
    getAdsFromApi();
  }

  int bottomBarActiveIndex = 0;
  bool isLoading = false;
  int pageSize = 10;

  Future<void> getAdsFromApi() async {
    String? token = Singleton.accessToken;
    isLoading = true;
    homeScreenState.refresh();
    try {
      Map<String, dynamic> bodyParam = {
        "CategoryId": null,
        "Distance": 0,
        "FilterId": 1,
        "Latitude": 37.0902,
        "Longitude": 95.7129,
        "SearchText": "",
        "SuSubCategoryList": [],
        "SubCategoryList": [],
        "deviceToken": token,
        "pageNo": 1,
        "pageSize": pageSize,
        "versionCode": "1.27",
        "mobileVersion": Platform.version,
        "osVersion": Platform.operatingSystemVersion,
        "countryId": "United States",
        "isRequestFromWeb": true
      };

      String? getAdsResponse = await RestServiceConstants.postRestMethods(
          endPoint: RestServiceConstants.getFilterAdApi, bodyParam: bodyParam);

      if (getAdsResponse != null && getAdsResponse.isNotEmpty) {
        Map<String, dynamic> getAdsResponseMap = jsonDecode(getAdsResponse);
        if (getAdsResponseMap.containsKey('Success') &&
            getAdsResponseMap['Success']) {
          homeScreenState.filteredAdsModel =
              getFilteredAdsModelFromJson(getAdsResponse);

          if (homeScreenState.mounted) {
            isLoading = false;
            homeScreenState.refresh();
          }
          log("filterAdListModel---->${homeScreenState.filteredAdsModel!.toJson()}");
        } else {
          isLoading = false;
          homeScreenState.refresh();
          appToast("${getAdsResponseMap['Message']}");
        }
      } else {
        isLoading = false;
        homeScreenState.refresh();
      }
    } on SocketException catch (e) {
      appToast(e.message);
    }
  }

  loadMore() {
    if (pageSize == homeScreenState.filteredAdsModel!.filteredAddList!.length) {
      homeScreenState.homeScreenViewModel!.pageSize =
          homeScreenState.homeScreenViewModel!.pageSize + 10;
      homeScreenState.homeScreenViewModel!.getAdsFromApi();
    }
  }
}
