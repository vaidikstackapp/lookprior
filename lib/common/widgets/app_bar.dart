import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/widgets/app_text.dart';

// ignore: must_be_immutable
class CommonAppBar extends StatelessWidget {
  String? title;
  Color? color;
  Widget? leadingWidget;
  double? textPadding;
  List<Widget>? action;
  CommonAppBar(
      {Key? key,
      this.title,
      this.color,
      this.leadingWidget,
      this.action,
      this.textPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //toolbarHeight: 200,
      leading: leadingWidget,
      centerTitle: true,
      elevation: 0,
      backgroundColor: color ?? ColorConstants.appColor,
      title: Padding(
        padding: EdgeInsets.only(bottom: textPadding ?? 0),
        child: AppText(
          text: title,
          fontSize: 20,
        ),
      ),
      actions: action,
    );
  }
}
