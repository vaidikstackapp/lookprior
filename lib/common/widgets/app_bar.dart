import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/widgets/app_text.dart';

// ignore: must_be_immutable
class CommonAppBar extends StatelessWidget {
  String? title;
  CommonAppBar({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: ColorConstants.appColor,
      title: AppText(
        text: title,
        fontSize: 20,
      ),
    );
  }
}
