import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/widgets/app_text.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  double? topPadding;
  double? bottomPadding;
  double? fontSize;
  double? iconHeight;
  double? buttonWidth;
  double? iconWidth;
  double? borderWidth;
  FontWeight? fontWeight;
  Function()? onTap;
  Color? buttonColor;
  Color? borderColor;
  Color? textColor;
  String? text;
  String? buttonIcon;
  String? url;
  AppButton(
      {super.key,
      this.topPadding,
      this.bottomPadding,
      this.text,
      this.fontSize,
      this.onTap,
      this.buttonColor,
      this.buttonIcon,
      this.iconHeight,
      this.iconWidth,
      this.textColor,
      this.borderColor,
      this.borderWidth,
      this.fontWeight,
      this.buttonWidth});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          left: 14,
          right: 18,
          top: topPadding ?? 0,
          bottom: bottomPadding ?? 0,
        ),
        child: Container(
          height: 58,
          width: buttonWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  color: borderColor ?? Colors.white, width: borderWidth ?? 0),
              color: buttonColor,
              borderRadius: BorderRadius.circular(6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (buttonIcon == null)
                  ? const SizedBox()
                  : Container(
                      height: iconHeight,
                      width: iconWidth,
                      margin: const EdgeInsets.only(right: 13.52),
                      child: SvgPicture.asset(
                        buttonIcon!,
                        fit: BoxFit.fill,
                      )),
              AppText(
                text: text,
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor ?? ColorConstants.textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
