import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:look_prior/common/contants/color_contants.dart';

// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  String? prefixIcon;
  String? suffixIcon;
  String? hintText;
  double? topMargin;
  double? hintTextSize;
  double? width;
  double? height;
  double? rightMargin;
  double? leftMargin;
  TextEditingController? controller;
  EdgeInsets? contentPadding;
  bool? obscureText;
  bool? readOnly;
  Function()? onTap;
  int? maxLines;
  FormFieldValidator<String>? validator;
  TextInputType? keyboardType;

  AppTextField(
      {super.key,
      this.prefixIcon,
      this.hintText,
      this.topMargin,
      this.hintTextSize,
      this.keyboardType,
      this.validator,
      this.obscureText,
      this.controller,
      this.width,
      this.height,
      this.rightMargin,
      this.leftMargin,
      this.suffixIcon,
      this.readOnly,
      this.contentPadding,
      this.onTap,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(
          left: leftMargin ?? 14,
          top: topMargin ?? 0,
          right: rightMargin ?? 18),
      child: TextFormField(
        maxLines: maxLines,
        onTap: onTap,
        readOnly: readOnly ?? false,
        obscureText: obscureText ?? false,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: ColorConstants.appColor,
        decoration: InputDecoration(
          prefixIcon: (prefixIcon != null)
              ? Container(
                  height: 32,
                  width: 32,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  margin: const EdgeInsets.only(
                      top: 7, left: 9, bottom: 8, right: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorConstants.appColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SvgPicture.asset(
                    prefixIcon!,
                    color: ColorConstants.appColor,
                  ),
                )
              : null,
          suffixIcon: (suffixIcon != null)
              ? Container(
                  height: 32,
                  width: 32,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  margin: const EdgeInsets.only(
                      top: 7, left: 9, bottom: 8, right: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SvgPicture.asset(
                    suffixIcon!,
                    color: Colors.black,
                  ),
                )
              : null,
          contentPadding: contentPadding,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: hintTextSize, color: Colors.black.withOpacity(1)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.appColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
