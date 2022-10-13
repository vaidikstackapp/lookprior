import 'package:flutter/material.dart';

import '../contants/color_contants.dart';
import 'app_background.dart';

// ignore: must_be_immutable
class AppScreenBackGround extends StatelessWidget {
  Widget? appbarWidget;
  Widget? bodyWidget;
  double? topPosition;
  double? appBarHeight;
  AppScreenBackGround(
      {Key? key,
      this.appbarWidget,
      this.appBarHeight,
      this.topPosition,
      this.bodyWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(children: [
          Container(
              height: appBarHeight ?? 100,
              color: ColorConstants.appColor,
              margin: const EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              child: appbarWidget),
          Positioned(
              top: topPosition ?? 93,
              bottom: 0,
              right: 0,
              left: 0,
              child: AppBackRound(
                widget: bodyWidget,
              )),
        ]),
      ),
    );
  }
}
