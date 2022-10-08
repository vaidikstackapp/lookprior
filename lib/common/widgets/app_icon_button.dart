import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_prior/common/contants/color_contants.dart';

// ignore: must_be_immutable
class AppIconButton extends StatelessWidget {
  double? horizontalPadding;
  double? verticalPadding;
  double? height;
  double? width;
  double? borderRadius;
  Color? color;
  String? iconName;
  Function()? iconOnTap;
  AppIconButton(
      {Key? key,
      this.horizontalPadding,
      this.verticalPadding,
      required this.iconName,
      this.iconOnTap,
      this.width,
      this.height,
      this.color,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: iconOnTap,
      child: Container(
        height: height ?? 40,
        width: width ?? 40,
        decoration: BoxDecoration(
            color: color ?? ColorConstants.appbarIconColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 8)),
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding ?? 0,
                vertical: verticalPadding ?? 0),
            child: SvgPicture.asset(
              "$iconName",
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
