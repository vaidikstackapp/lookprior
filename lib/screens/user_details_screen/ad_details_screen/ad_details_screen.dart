import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/contants/icon_constants.dart';
import 'package:look_prior/common/contants/string_contants.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_icon_button.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/model/get_ad_data_model.dart';
import 'package:look_prior/screens/post_ad_screen/full_screen_view_image.dart';
import 'package:look_prior/screens/post_ad_screen/play_video_screen.dart';
import 'package:look_prior/screens/user_details_screen/ad_details_screen/ad_detail_screen_view_model.dart';

import '../../../model/get_ad_brodcast_detail_model.dart';
import '../../../utils/scroll_brehavior.dart';

// ignore: must_be_immutable
class FullAdDetailScreen extends StatefulWidget {
  FilteredAddList adDetail;

  FullAdDetailScreen(this.adDetail, {Key? key}) : super(key: key);

  @override
  State<FullAdDetailScreen> createState() => FullAdDetailScreenState();
}

class FullAdDetailScreenState extends State<FullAdDetailScreen> {
  FullAdDetailViewModel? detailViewModel;
  GetBroadcastDetailModel? broadcastDetailModel;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    detailViewModel ?? (detailViewModel = FullAdDetailViewModel(this));
    return WillPopScope(
      onWillPop: () {
        if (detailViewModel!.isLoading) {
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        body: (detailViewModel!.isLoading)
            ? const Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.appColor,
                ),
              )
            : fullAdDetailScreenBody(),
      ),
    );
  }

  Widget fullAdDetailScreenBody() {
    return Stack(
      children: [
        ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(),
                      child: PageView.builder(
                        onPageChanged: (value) {
                          detailViewModel!.cnt = value;
                          setState(() {});
                        },
                        controller: pageController,
                        itemCount: detailViewModel!.allVideoAndImage.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (broadcastDetailModel!.adImage == []) {
                                Navigator.push(
                                    context,
                                    CustomRoutes(
                                        child: PlayVideoScreen(
                                            "${broadcastDetailModel!.adVideo![index].video}")));
                              } else {
                                Navigator.push(
                                    context,
                                    CustomRoutes(
                                        child: ViewImageScreen(
                                            '${broadcastDetailModel!.adImage![index].image}')));
                              }
                            },
                            child: Image.network(
                              detailViewModel!.allVideoAndImage[index],
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress != null) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: ColorConstants.appColor,
                                    ),
                                  );
                                }
                                return child;
                              },
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 180),
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: ColorConstants.containerBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: broadcastDetailModel!.title,
                                color: ColorConstants.fontColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                              AppText(
                                text: "\$${broadcastDetailModel!.amount}",
                                color: ColorConstants.appColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  IconConstants.locationIcon,
                                  height: 15,
                                  width: 12.75,
                                  color:
                                      ColorConstants.fontColor.withOpacity(0.5),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                AppText(
                                  text: broadcastDetailModel!.location,
                                  color:
                                      ColorConstants.fontColor.withOpacity(0.4),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3, top: 17.5),
                            child: AppText(
                              text: "Images",
                              color: ColorConstants.fontColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          SizedBox(
                            height: 80,
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: ListView.builder(
                                itemCount:
                                    detailViewModel!.allVideoAndImage.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    imageList(index),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          AppText(
                            text: StringConstants.description,
                            color: ColorConstants.fontColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppText(
                            text: broadcastDetailModel!.description,
                            color: ColorConstants.fontColor.withOpacity(0.4),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: AppText(
                              text: "Similar ads",
                              color: ColorConstants.fontColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          ListView.builder(
                            itemCount: 3,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                similarAdList(index),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 10,
                      child: Container(
                        height: 39.33,
                        width: 39.33,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.shareButtonColor,
                        ),
                        child: PopupMenuButton(
                            onSelected: (value) {
                              if (value == 1) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: AppText(
                                        color: ColorConstants.fontColor,
                                        text:
                                            "Are you sure you want to delete this ad?",
                                      ),
                                      actions: [
                                        GestureDetector(
                                          onTap: () => reasonDeleteDialog(),
                                          child: AppText(
                                            text: "YES",
                                            color: ColorConstants.appColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: AppText(
                                            text: "NO",
                                            color: ColorConstants.appColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            offset: const Offset(-10, 40),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                      value: 0,
                                      child: AppText(
                                        text: "Edit",
                                        color: ColorConstants.fontColor,
                                      )),
                                  PopupMenuItem(
                                      value: 1,
                                      child: AppText(
                                        text: "Delete",
                                        color: ColorConstants.fontColor,
                                      )),
                                ],
                            icon: Icon(
                              Icons.more_horiz,
                              color: ColorConstants.white,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 30,
          left: 10,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 39.33,
              width: 39.33,
              decoration: BoxDecoration(
                  color: ColorConstants.shareButtonColor,
                  borderRadius: BorderRadius.circular(39.33)),
              child: Icon(
                Icons.navigate_before,
                color: ColorConstants.white,
              ),
            ),
          ),
        ),
        (detailViewModel!.isLoadingDelete)
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.transparent,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.appColor,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }

  imageList(int index) {
    return GestureDetector(
      onTap: () {
        detailViewModel!.cnt = index;
        pageController.jumpToPage(detailViewModel!.cnt);
        setState(() {});
      },
      child: Container(
          height: 80,
          width: 80,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              detailViewModel!.allVideoAndImage[index],
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.appColor,
                    ),
                  );
                }
                return child;
              },
            ),
          )),
    );
  }

  similarAdList(int index) {
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (broadcastDetailModel!.similarAddList![index].adImageThumb!.isEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              "${broadcastDetailModel!.similarAddList![index].adVideoThumb}",
              fit: BoxFit.fill,
            ),
          )
        else
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              "${broadcastDetailModel!.similarAddList![index].adImageThumb}",
              fit: BoxFit.fill,
              height: 100,
              width: double.infinity,
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: AppText(
                    text:
                        "${broadcastDetailModel!.similarAddList![index].title}",
                    color: ColorConstants.fontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: AppText(
                    text:
                        "\$${broadcastDetailModel!.similarAddList![index].amount}",
                    color: ColorConstants.appColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AppIconButton(
                iconName: IconConstants.shareIcon,
                width: 100,
                height: 35,
                color: ColorConstants.shareButtonColor.withOpacity(0.5),
              ),
            ),
          ],
        )
      ],
    ));
  }

  reasonDeleteDialog() {
    Navigator.pop(context);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SimpleDialog(
              title: AppText(
                text: "Why are you removing this ad?",
                color: ColorConstants.fontColor,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
              children: [
                Row(
                  children: [
                    Checkbox(
                      checkColor: ColorConstants.white,
                      value: detailViewModel!.isCheck1,
                      fillColor: const MaterialStatePropertyAll(
                          ColorConstants.appColor),
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onChanged: (value) {
                        detailViewModel!.isCheck2 = false;
                        detailViewModel!.isCheck1 = value!;
                        setState(() {});
                      },
                    ),
                    AppText(
                      text: "Sold out this product",
                      color: ColorConstants.fontColor,
                    )
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: ColorConstants.white,
                      value: detailViewModel!.isCheck2,
                      fillColor: const MaterialStatePropertyAll(
                          ColorConstants.appColor),
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onChanged: (value) {
                        detailViewModel!.isCheck1 = false;
                        detailViewModel!.isCheck2 = value!;
                        setState(() {});
                      },
                    ),
                    AppText(
                      text: "Change my mind",
                      color: ColorConstants.fontColor,
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onTap: () => Navigator.pop(context),
                        text: "Cancel",
                        buttonColor: ColorConstants.shareButtonColor,
                      ),
                    ),
                    Expanded(
                      child: AppButton(
                        onTap: () => detailViewModel!.removeButtonOnTap(),
                        text: "Remove",
                        buttonColor: ColorConstants.appColor,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
