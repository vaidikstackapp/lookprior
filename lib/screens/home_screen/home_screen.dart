import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/contants/images_contants.dart';
import 'package:look_prior/common/contants/string_contants.dart';
import 'package:look_prior/common/widgets/app_icon_button.dart';
import 'package:look_prior/common/widgets/app_bar_text_field.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_product_list.dart';
import 'package:look_prior/common/widgets/app_screen_backgroud.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/screens/home_screen/home_screen_view_model.dart';
import 'package:look_prior/screens/location_screen/location_screen.dart';

import 'package:look_prior/screens/storage_plan_screen/storage_plan_screen.dart';
import 'package:look_prior/screens/user_details_screen/ad_details_screen/ad_details_screen.dart';
import 'package:look_prior/utils/scroll_behavior.dart';
import 'package:look_prior/utils/share_preference.dart';
import 'package:look_prior/utils/single_tone.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/contants/icon_constants.dart';

import '../../model/get_filtered_ads.dart';
import '../catagory_screen/catagory_screen.dart';
import '../notification_screen/notification_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  GlobalKey<ScaffoldState>? scaffoldKey;

  HomeScreen(
      {required this.scaffoldKey,
      super.key}); //final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel? homeScreenViewModel;
  GetFilteredAdsModel? filteredAdsModel;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final bool dialogOpen = prefs.getBool('dialog_open') ?? false;
      if (dialogOpen == false) {
        Future.delayed(const Duration(seconds: 3), () async => dialog());
        prefs.setBool("dialog_open", true);
      }
    });
    getToken();
  }

  Future<void> getToken() async {
    Singleton.accessToken = await getPrefStringValue(accessToken);
    Singleton.uid = await getPrefIntValue(userId);

    log("uid--->${Singleton.uid}");
    log("accessToken--->${Singleton.accessToken}");
  }

  void dialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 13),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Image.asset(ImageConstants.welcomeImage),
          children: [
            Column(
              children: [
                AppText(
                  text: "Welcome!",
                  color: ColorConstants.headerColor,
                  textAlign: TextAlign.center,
                  fontSize: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: AppText(
                    fontSize: 13,
                    text: StringConstants.dialogBoxText,
                    textAlign: TextAlign.center,
                    color: ColorConstants.headerColor,
                  ),
                ),
                AppButton(
                  onTap: () => Navigator.of(context).pop(),
                  topPadding: 7,
                  text: "Post my first ad now",
                  buttonColor: ColorConstants.appColor,
                ),
                AppButton(
                  topPadding: 15,
                  bottomPadding: 15,
                  onTap: () => Navigator.of(context).pop(),
                  text: "Browse Listing",
                  buttonColor: ColorConstants.appleButtonColor,
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    homeScreenViewModel ?? (homeScreenViewModel = HomeScreenViewModel(this));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppScreenBackGround(
        appBarHeight: 200,
        appbarWidget: homeScreenAppBar(),
        topPosition: 170,
        bodyWidget: homeScreenContent(),
      ),
    );
  }

  Widget homeScreenAppBar() {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 14, right: 19, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () => (widget.scaffoldKey!.currentState != null)
                      ? widget.scaffoldKey!.currentState!.openDrawer()
                      : null,
                  child: SvgPicture.asset(IconConstants.drawerIcon)),
              Image.asset(
                IconConstants.appLogoWithoutColor,
                alignment: Alignment.center,
                height: 50,
                width: 80,
                fit: BoxFit.fill,
              ),
              AppIconButton(
                  iconOnTap: () => Navigator.push(
                      context,
                      CustomRoutes(
                        child: const NotificationScreen(),
                      )),
                  iconName: IconConstants.notificationIcon),
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 0, left: 14, right: 15, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBarTextField(
                hintText: "Search here",
                fontSize: 14,
                icon: IconConstants.searchIcon,
              ),
              PopupMenuButton<int>(
                offset: const Offset(20, 40),
                padding: const EdgeInsets.only(top: 10),
                child: AppIconButton(iconName: IconConstants.filterIcon),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      child: AppText(
                    text: "All",
                    color: ColorConstants.fontColor,
                  )),
                  PopupMenuItem(
                      child: AppText(
                    text: "Top",
                    color: ColorConstants.fontColor,
                  )),
                  PopupMenuItem(
                      child: AppText(
                    text: "Regular",
                    color: ColorConstants.fontColor,
                  )),
                ],
              ),
              AppIconButton(
                  iconOnTap: () => Navigator.push(
                      context, CustomRoutes(child: const LocationScreen())),
                  iconName: IconConstants.locationIcon),
            ],
          ),
        ),
      ],
    );
  }

  Widget homeScreenContent() {
    return (filteredAdsModel == null)
        ? const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.appColor,
            ),
          )
        : Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: Scrollbar(
                    controller: controller,
                    thumbVisibility: true,
                    child: LazyLoadScrollView(
                      onEndOfPage: () => homeScreenViewModel!.loadMore(),
                      child: ListView(
                        shrinkWrap: true,
                        controller: controller,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: AppText(
                              textAlign: TextAlign.start,
                              color: ColorConstants.headerColor,
                              text: "Catagory",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            height: 100,
                            alignment: Alignment.center,
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    IconConstants.catagoryListIcon.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: (index == 0)
                                        ? const EdgeInsets.only(left: 0)
                                        : const EdgeInsets.only(left: 16),
                                    child: Column(
                                      children: [
                                        AppIconButton(
                                            height: 71,
                                            width: 76,
                                            color: ColorConstants
                                                .catagoryListColor,
                                            iconName: IconConstants
                                                .catagoryListIcon[index]),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: AppText(
                                            text: StringConstants
                                                .catagoryListTitle[index],
                                            fontSize: 11,
                                            color: ColorConstants.fontColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: AppText(
                              textAlign: TextAlign.start,
                              color: ColorConstants.headerColor,
                              text: "Near you",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Column(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    filteredAdsModel!.filteredAddList!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 2,
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.78),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        CustomRoutes(
                                            child: FullAdDetailScreen(
                                                filteredAdsModel!
                                                    .filteredAddList![index]
                                                    .broadCastId))),
                                    child: AppProductList(
                                      width: 100,
                                      pictureHeight: 100,
                                      pictureWidth: 130,
                                      paddingLeft: 10,
                                      image: (filteredAdsModel!
                                              .filteredAddList![index]
                                              .adImageThumb!
                                              .isEmpty)
                                          ? filteredAdsModel!
                                              .filteredAddList![index]
                                              .adVideoThumb
                                          : filteredAdsModel!
                                              .filteredAddList![index]
                                              .adImageThumb,
                                      productName: filteredAdsModel!
                                          .filteredAddList![index].title,
                                      productPrize: filteredAdsModel!
                                          .filteredAddList![index].amountStr!
                                          .split(".")[0],
                                      address: filteredAdsModel!
                                          .filteredAddList![index].fullAddress,
                                    ),
                                  );
                                },
                              ),
                              (filteredAdsModel == null)
                                  ? const SizedBox()
                                  : (homeScreenViewModel!.isLoading)
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: ColorConstants.appColor,
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 20,
                                        ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  void refresh() {
    setState(() {});
  }
}

drawerListOnTap(int index, BuildContext context,
    GlobalKey<ScaffoldState> scaffoldKey, bool mounted) async {
  switch (index) {
    case 1:
      Navigator.pop(context);
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return null;
      Navigator.push(context, CustomRoutes(child: const CatagoryScreen()));
      break;
    case 3:
      Navigator.pop(context);
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return null;
      Navigator.push(context, CustomRoutes(child: const StoragePlanScreen()));
      break;
  }
}

Widget filterOnTap() {
  return PopupMenuButton<int>(
    itemBuilder: (context) => [
      PopupMenuItem(
          value: 1,
          child: AppText(
            text: "All",
          )),
      PopupMenuItem(
          value: 2,
          child: AppText(
            text: "Top",
          )),
      PopupMenuItem(
          value: 3,
          child: AppText(
            text: "Regular",
          )),
    ],
  );
}
