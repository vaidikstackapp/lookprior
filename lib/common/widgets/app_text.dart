import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/color_contants.dart';

// ignore: must_be_immutable
class AppText extends StatelessWidget {
  String? text;
  double? fontSize;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  Color? color;

  AppText(
      {super.key,
      this.text,
      this.fontSize,
      this.textAlign,
      this.color,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? ColorConstants.textColor,
      ),
      textAlign: textAlign,
    );
  }
}
