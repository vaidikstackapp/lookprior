import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/widgets/app_text.dart';

class AppListTile extends StatelessWidget {
  Color? color;
  double? width;
  double? height;
  String? image;
  String? title;
  String? subTitle;

  AppListTile(
      {Key? key,
      this.color,
      this.width,
      this.height,
      this.image,
      this.title,
      this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(4), color: color),
        child: SvgPicture.asset(image!),
      ),
      title: AppText(
        text: title,
        color: ColorConstants.fontColor,
      ),
    );
  }
}
