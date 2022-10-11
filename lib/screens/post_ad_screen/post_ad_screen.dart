import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_prior/common/contants/icon_constants.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/utils/scroll_behavior/scroll_brehavior.dart';

import '../../common/contants/color_contants.dart';
import '../../common/widgets/app_background.dart';
import '../../common/widgets/app_text.dart';

class PostAdScreen extends StatefulWidget {
  const PostAdScreen({Key? key}) : super(key: key);

  @override
  State<PostAdScreen> createState() => _PostAdScreenState();
}

class _PostAdScreenState extends State<PostAdScreen> {
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
                  width: 70,
                ),
                AppText(
                  fontSize: 20,
                  textAlign: TextAlign.center,
                  text: "Post your Ad",
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
                widget: postAdContent(),
              )),
        ]),
      ),
    );
  }

  String description =
      "Tap the icon below to record a short video for your listing. Your video file size must be 6MB or less. Post up to 3 videos for free! Need to upload a larger video file or want to add more than three? That's OK! We have many storage options to choose from. You will be able to post larger video files after increasing the storage capacity";
  String descriptionPhoto =
      "Quality images of your items will attract more buyers. Use the icon below to take pictures or upload images already stored on your phone.";
  Widget postAdContent() {
    return Column(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    child: GridTileBar(
                        leading: AppText(
                          text: "Media",
                          color: ColorConstants.fontColor,
                          fontSize: 18,
                        ),
                        title: const SizedBox(),
                        trailing:
                            SvgPicture.asset(PostAdIconConstants.infoIcon)),
                  ),
                ),
                Card(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    children: [
                      AppText(
                        fontSize: 12,
                        text:
                            "Listing with videos sell 20x faster compared to ads without videos",
                        color: ColorConstants.fontColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: AppText(
                          fontSize: 11,
                          text: description,
                          color: ColorConstants.fontColor.withOpacity(0.5),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 109,
                            width: 113,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        PostAdIconConstants.background))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.video_call,
                                  size: 30,
                                  color: ColorConstants.appColor,
                                ),
                                AppText(
                                  fontSize: 13,
                                  text: "Add Videos",
                                  color: ColorConstants.appColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    children: [
                      AppText(
                        fontSize: 15,
                        text:
                            "Add Photos to attract more people to your listing.",
                        color: ColorConstants.fontColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: AppText(
                          fontSize: 11,
                          text: descriptionPhoto,
                          color: ColorConstants.fontColor.withOpacity(0.5),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 109,
                            width: 113,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        PostAdIconConstants.background))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_a_photo,
                                  size: 25,
                                  color: ColorConstants.appColor,
                                ),
                                AppText(
                                  fontSize: 13,
                                  text: "Add  Photos",
                                  color: ColorConstants.appColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: AppText(
                          fontSize: 11,
                          text:
                              "Need to upload a larger video file? That's OK! We have many storage options to choose from. The more you showcase the items, the faster they sell.",
                          color: ColorConstants.fontColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                fontSize: 13,
                text: "Go to my options",
                color: ColorConstants.appColor,
              ),
              const Icon(
                Icons.arrow_forward,
                color: ColorConstants.appColor,
                size: 13,
              ),
            ],
          ),
        ),
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