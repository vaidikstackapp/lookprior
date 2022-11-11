import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:look_prior/common/widgets/app_bar.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../../common/contants/color_contants.dart';

// ignore: must_be_immutable
class ViewImageScreen extends StatelessWidget {
  String image;

  ViewImageScreen(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("imagepath---->$image");
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(children: [
          Container(
              height: 100,
              color: ColorConstants.appColor,
              margin: const EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              child: CommonAppBar(
                title: "Image",
              )),
          Positioned(
              top: 93,
              bottom: 0,
              right: 0,
              left: 0,
              child: Zoom(
                scrollWeight: 0,
                backgroundColor: Colors.white,
                initTotalZoomOut: true,
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                ),
              )),
        ]),
      ),
    );
  }
}
