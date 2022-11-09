import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/widgets/app_text.dart';

import '../contants/icon_constants.dart';

// ignore: must_be_immutable
class AppProductList extends StatelessWidget {
  String? image;
  String? productName;
  String? productPrize;
  String? address;
  double? height;
  double? width;
  double? pictureWidth;
  double? pictureHeight;
  double? paddingLeft;

  AppProductList(
      {super.key,
      this.image,
      this.productName,
      this.productPrize,
      this.height,
      this.width,
      this.pictureHeight,
      this.pictureWidth,
      this.paddingLeft,
      this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              height: pictureHeight,
              width: pictureWidth,
              margin: const EdgeInsets.all(5),
              alignment: Alignment.topRight,
              decoration: (image != null)
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(image!), fit: BoxFit.cover))
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(IconConstants.likeButtonIcon),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: AppText(
                        textOverFlow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        text: productName,
                        color: ColorConstants.fontColor,
                      ),
                    ),
                  ),
                  Flexible(
                    child: AppText(
                      textOverFlow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      text: "\$$productPrize",
                      color: ColorConstants.appColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: paddingLeft ?? 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    IconConstants.locationIcon,
                    height: 9.7,
                    width: 7.79,
                    color: Colors.black,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: AppText(
                        textOverFlow: TextOverflow.ellipsis,
                        text: address,
                        color: ColorConstants.fontColor.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => 123,
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(ColorConstants.appColor)),
                    child: SvgPicture.asset(IconConstants.shareIcon),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    IconConstants.starIcon,
                    width: 35,
                    height: 35,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
