import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/contants/icon_constants.dart';
import 'package:look_prior/common/contants/string_contants.dart';
import 'package:look_prior/common/widgets/app_bar.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_screen_backgroud.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/common/widgets/app_textfield.dart';
import '../../utils/scroll_behavior/scroll_brehavior.dart';

class AdDetailScreen extends StatefulWidget {
  const AdDetailScreen({Key? key}) : super(key: key);

  @override
  State<AdDetailScreen> createState() => _AdDetailScreenState();
}

class _AdDetailScreenState extends State<AdDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreenBackGround(
        appbarWidget: CommonAppBar(title: StringConstants.postAd),
        bodyWidget: adDetailContent(),
      ),
    );
  }

  final key = GlobalKey<FormState>();
  Widget adDetailContent() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: Card(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: Form(
              key: key,
              child: ListView(
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                children: [
                  AppText(
                    text: "Ad Details",
                    fontSize: 18,
                    color: ColorConstants.fontColor,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppText(
                    text: "Title",
                    fontSize: 16,
                    color: ColorConstants.fontColor.withOpacity(0.4),
                  ),
                  AppTextField(
                    topMargin: 14,
                    contentPadding: const EdgeInsets.only(top: 10, left: 10),
                    leftMargin: 0,
                    rightMargin: 0,
                    hintText: "Title",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText(
                    text: "Amount",
                    fontSize: 16,
                    color: ColorConstants.fontColor.withOpacity(0.4),
                  ),
                  AppTextField(
                    topMargin: 14,
                    contentPadding: const EdgeInsets.only(top: 10, left: 10),
                    leftMargin: 0,
                    rightMargin: 0,
                    hintText: "Amount (\$)",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText(
                    text: "Description",
                    fontSize: 14,
                    color: ColorConstants.fontColor.withOpacity(0.4),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextField(
                    topMargin: 5,
                    leftMargin: 0,
                    rightMargin: 0,
                    maxLines: 6,
                    hintText: "Description",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText(
                    text: "Select Category",
                    fontSize: 14,
                    color: ColorConstants.fontColor.withOpacity(0.4),
                  ),
                  AppTextField(
                    topMargin: 14,
                    contentPadding: const EdgeInsets.only(top: 10, left: 10),
                    leftMargin: 0,
                    rightMargin: 0,
                    readOnly: true,
                    suffixIcon: IconConstants.dropDownIcon,
                    hintText: "Select Category",
                  ),
                ],
              ),
            ),
          ),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: AppButton(
            buttonColor: ColorConstants.appColor,
            text: "Next",
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
