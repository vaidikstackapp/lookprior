import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/screens/manage_screen/screens.dart';
import 'package:look_prior/service/rest_service.dart';
import 'package:look_prior/utils/single_tone.dart';
import 'package:http/http.dart' as http;
import 'post_ad_details_screen.dart';

class PostAdDetailViewModel {
  AdDetailScreenState screenState;

  PostAdDetailViewModel(this.screenState);

  final key = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  postAdButtonOnTap() {
    if (key.currentState!.validate()) {
      addDataInApi();
    }
  }

  titleValidator(String? value) {
    if (value!.isEmpty) {
      return "Enter Title";
    }
  }

  amountValidator(String? value) {
    if (value!.isEmpty) {
      return "Enter Amount";
    }
  }

  descriptionValidator(String? value) {
    if (value!.isEmpty) {
      return "Enter Description";
    }
  }

  Future<void> addDataInApi() async {
    String? token = Singleton.accessToken;
    try {
      isLoading = true;
      screenState.refresh();
      http.MultipartRequest request = http.MultipartRequest(
          'POST', Uri.parse(RestServiceConstants.postAdDetailApi));
      log("bytesImagePath${request.url}");

      request.headers.addAll(
        {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      );

      request.fields.addAll({
        'addDetailId': '',
        'servicePackId': '',
        'totalExposureDays': '',
        'perDayExposurePrice': '',
        'title': titleController.text.trim(),
        'cityName': 'Surat',
        'stateName': 'Gujarat',
        'description': descriptionController.text.trim(),
        'amount': amountController.text.trim(),
        'addType': '1',
        'categoryId': '1',
        'subCategoryId': '1',
        'suSubCategoryId': '0',
        'latitude': '21.1702401',
        'longitude': '72.8310607',
        'countryId': 'india',
        'distance': '158',
        'location': 'Surat, Gujarat, India',
        'broadCastAmount': '0.0',
        'currency': 'INR',
        'videoSize': '',
        'videoDuration': '',
        'adVideoList[0].videoSize': '10',
        'adVideoList[0].videoDuration': '8'
      });
      for (var i = 0; i < screenState.widget.imagePath.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            'adImageList[$i]', screenState.widget.imagePath[i].path));
        log("imgPath${screenState.widget.imagePath[i].path}");
      }
      for (var i = 0; i < screenState.widget.videoPath.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            'adVideoList[$i].adVideo', screenState.widget.videoPath[i].path));
        log("videoPath${screenState.widget.videoPath[i].path}");
      }

      http.StreamedResponse response = await request.send();
      log("response code----->${response.statusCode}");

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        log("respStr---->$respStr");

        Map<String, dynamic> responseMap = jsonDecode(respStr);

        if (responseMap.containsKey('Success') && responseMap['Success']) {
          appToast(responseMap['Message']);
          if (screenState.mounted) {
            isLoading = false;
            screenState.refresh();
            Navigator.pushAndRemoveUntil(
                screenState.context,
                CustomRoutes(
                    child: const Screens(
                  index: 3,
                )),
                (route) => false);
          }
        } else {
          isLoading = false;
          screenState.refresh();
          appToast(responseMap['Message']);
        }
      } else {
        isLoading = false;
        screenState.refresh();
        log("${response.reasonPhrase}");
      }
    } on SocketException catch (e) {
      log('PlatformException in postRestCall --> ${e.message}');
      isLoading = false;
      screenState.refresh();
      appToast("Network required");
    }
  }
}
