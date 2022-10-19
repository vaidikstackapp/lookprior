import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/widgets/app_text.dart';

// ignore: must_be_immutable
class CommonAppBar extends StatelessWidget {
  String? title;
  Color? color;
  CommonAppBar({Key? key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: color ?? ColorConstants.appColor,
      title: AppText(
        text: title,
        fontSize: 20,
      ),
    );
  }
}
