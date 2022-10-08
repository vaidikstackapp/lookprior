import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_prior/common/contants/color_contants.dart';

// ignore: must_be_immutable
class AppBarTextField extends StatelessWidget {
  String? hintText;
  String? icon;
  double? fontSize;

  AppBarTextField({super.key, this.hintText, this.icon, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: 231,
      margin: const EdgeInsets.only(right: 4),
      alignment: Alignment.center,
      child: TextField(
        style: const TextStyle(color: ColorConstants.textColor),
        cursorColor: Colors.white,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 5, left: 10),
            filled: true,
            prefixIcon: Container(
              height: 20,
              width: 20,
              alignment: Alignment.center,
              child: (icon != null)
                  ? SvgPicture.asset(
                      icon!,
                      fit: BoxFit.contain,
                    )
                  : null,
            ),
            fillColor: ColorConstants.appbarIconColor,
            hintText: hintText,
            hintStyle:
                TextStyle(color: ColorConstants.textColor, fontSize: fontSize),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.appbarIconColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.appbarIconColor)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(),
                borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
