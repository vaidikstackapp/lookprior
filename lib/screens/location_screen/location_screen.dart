import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_prior/common/contants/icon_constants.dart';
import 'package:look_prior/common/contants/images_contants.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_icon_button.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/common/widgets/app_textfield.dart';

import '../../common/contants/color_contants.dart';
import '../../common/widgets/app_background.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(children: [
          Container(
            height: 100,
            color: ColorConstants.appColor,
            margin: const EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.navigate_before,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                AppText(
                  fontSize: 20,
                  textAlign: TextAlign.center,
                  text: "Select Category",
                )
              ],
            ),
          ),
          Positioned(
              top: 100,
              bottom: 0,
              right: 0,
              left: 0,
              child: AppBackRound(
                widget: locationScreenContent(),
              )),
        ]),
      ),
    );
  }

  double changedValue = 40;
  Widget locationScreenContent() {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 26),
        shrinkWrap: true,
        children: [
          AppText(
            text: 'Catagory',
            fontSize: 14,
            color: ColorConstants.fontColor.withOpacity(0.4),
          ),
          AppTextField(
            height: 58,
            topMargin: 14,
            leftMargin: 0,
            rightMargin: 0,
            prefixIcon: IconConstants.moreIcon,
            readOnly: true,
            suffixIcon: LocationIconConstants.moveIcon,
            hintText: "Select category",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: AppText(
              text: 'Location',
              fontSize: 14,
              color: ColorConstants.fontColor.withOpacity(0.4),
            ),
          ),
          AppTextField(
            height: 58,
            topMargin: 14,
            leftMargin: 0,
            rightMargin: 0,
            prefixIcon: IconConstants.locationIcon,
            readOnly: true,
            suffixIcon: LocationIconConstants.editIcon,
            hintText: "California, USA",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: AppText(
              text: 'Select Distance',
              fontSize: 14,
              color: ColorConstants.fontColor.withOpacity(0.4),
            ),
          ),
          Slider(
            divisions: 5,
            value: changedValue,
            min: 0,
            label: (changedValue == 250) ? "Max" : "$changedValue/m",
            activeColor: ColorConstants.appColor,
            inactiveColor: const Color(0xff333333).withOpacity(0.6),
            max: 250,
            onChanged: (value) {
              changedValue = value;
              setState(() {});
            },
          ),
          Container(
            height: 403,
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(LocationImgConstants.locationImg),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 45),
                  child: AppIconButton(
                    iconName: LocationIconConstants.currentLocationIcon,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SvgPicture.asset(LocationIconConstants.locationIcon),
                ),
                const SizedBox(
                  height: 27,
                )
              ],
            ),
          ),
          AppButton(
            text: "Apply",
            buttonColor: ColorConstants.appColor,
            topPadding: 15,
            fontSize: 16,
          )
        ],
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
