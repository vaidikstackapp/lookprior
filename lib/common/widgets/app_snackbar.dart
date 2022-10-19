import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/widgets/app_text.dart';

SnackBar appSnackBar(String? message,
        {String? lable,
        Function()? onTap,
        Color? labelColor,
        Color? textColor}) =>
    SnackBar(
      dismissDirection: DismissDirection.none,
      backgroundColor: ColorConstants.appColor,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AppText(
              text: message,
              fontSize: 17,
              color: textColor ?? ColorConstants.textColor,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: 50,
              child: AppText(
                text: lable,
                fontSize: 17,
                textAlign: TextAlign.end,
                color: labelColor ?? ColorConstants.textColor,
              ),
            ),
          )
        ],
      ),
    );
