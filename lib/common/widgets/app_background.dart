import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/color_contants.dart';

// ignore: must_be_immutable
class AppBackRound extends StatelessWidget {
  Widget? widget;

  AppBackRound({super.key, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: ColorConstants.containerBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: widget,
    );
  }
}
