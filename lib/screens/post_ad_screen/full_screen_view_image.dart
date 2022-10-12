import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:look_prior/common/widgets/app_bar.dart';

import '../../common/contants/color_contants.dart';
import '../../common/widgets/app_background.dart';

// ignore: must_be_immutable
class ViewImageScreen extends StatelessWidget {
  XFile image;

  ViewImageScreen(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: AppBackRound(
                widget: Hero(
                    tag: image.path,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      child: Image.file(
                        File(image.path),
                        fit: BoxFit.fill,
                      ),
                    )),
              )),
        ]),
      ),
    );
  }
}
