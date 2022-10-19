import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:look_prior/common/contants/color_contants.dart';

appToast(String? toastMessage) {
  Fluttertoast.showToast(
      msg: "$toastMessage",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: ColorConstants.fontColor,
      fontSize: 16.0);
}
