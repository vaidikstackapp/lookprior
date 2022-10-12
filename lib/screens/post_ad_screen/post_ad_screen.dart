import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:look_prior/common/contants/icon_constants.dart';
import 'package:look_prior/common/widgets/app_bar.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/screens/post_ad_screen/full_screen_view_image.dart';
import 'package:look_prior/screens/post_ad_screen/post_ad_screen_view_model.dart';
import 'package:look_prior/utils/scroll_behavior/scroll_brehavior.dart';

import '../../common/contants/color_contants.dart';
import '../../common/widgets/app_background.dart';
import '../../common/widgets/app_text.dart';

class PostAdScreen extends StatefulWidget {
  const PostAdScreen({Key? key}) : super(key: key);

  @override
  State<PostAdScreen> createState() => PostAdScreenState();
}

class PostAdScreenState extends State<PostAdScreen> {
  PostAdScreenViewModel? postAdScreenViewModel;

  @override
  Widget build(BuildContext context) {
    postAdScreenViewModel ??
        (postAdScreenViewModel = PostAdScreenViewModel(this));
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
            child: CommonAppBar(title: "Post your Ad"),
          ),
          Positioned(
              top: 93,
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

  Widget postAdContent() {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
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
                videoContent(),
                imageContent(),
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

  Widget videoContent() {
    return Card(
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
              text: postAdScreenViewModel!.videoDescription,
              color: ColorConstants.fontColor.withOpacity(0.5),
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () => videoBottomSheet(),
                child: Container(
                  height: 109,
                  width: 113,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(PostAdIconConstants.background))),
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
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget imageContent() {
    return Card(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10),
        children: [
          AppText(
            fontSize: 15,
            text: "Add Photos to attract more people to your listing.",
            color: ColorConstants.fontColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: AppText(
              fontSize: 11,
              text: postAdScreenViewModel!.photoDescription,
              color: ColorConstants.fontColor.withOpacity(0.5),
            ),
          ),
          if (postAdScreenViewModel!.imagePath.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    height: 109,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: postAdScreenViewModel!.imagePath.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: InkWell(
                            onTap: () =>
                                Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ViewImageScreen(
                                    postAdScreenViewModel!.imagePath[index]);
                              },
                            )),
                            child: Hero(
                              tag: postAdScreenViewModel!.imagePath[index].path,
                              child: Image.file(
                                  height: 109,
                                  width: 113,
                                  fit: BoxFit.fill,
                                  File(postAdScreenViewModel!
                                      .imagePath[index].path)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () => imageBottomSheet(),
                      child: Container(
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
                    ),
                  ),
                ],
              ),
            )
          else
            Row(
              children: [
                InkWell(
                  onTap: () => imageBottomSheet(),
                  child: Container(
                    height: 109,
                    width: 113,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(PostAdIconConstants.background))),
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
                )
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
    );
  }

  Future videoBottomSheet() {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), topLeft: Radius.circular(25))),
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(
                  text: "Record Video",
                  fontSize: 18,
                  color: ColorConstants.fontColor,
                ),
                const Divider(),
                AppText(
                  text: "Choose from library",
                  fontSize: 18,
                  color: ColorConstants.fontColor,
                ),
                const Divider(),
                AppText(
                  text: "Cancel",
                  fontSize: 18,
                  color: Colors.red,
                ),
              ]),
        );
      },
    );
  }

  Future imageBottomSheet() {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), topLeft: Radius.circular(25))),
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    postAdScreenViewModel!.imageSource(ImageSource.camera);
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: AppText(
                    text: "Click Image",
                    fontSize: 18,
                    color: ColorConstants.fontColor,
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () async {
                    postAdScreenViewModel!.multiImagePicker();
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: AppText(
                    text: "Choose from library",
                    fontSize: 18,
                    color: ColorConstants.fontColor,
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: AppText(
                    text: "Cancel",
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              ]),
        );
      },
    );
  }

  void refresh() {
    setState(() {});
  }
}
