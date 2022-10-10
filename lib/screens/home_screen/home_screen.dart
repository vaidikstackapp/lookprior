import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/contants/images_contants.dart';
import 'package:look_prior/common/contants/string_contants.dart';
import 'package:look_prior/common/widgets/app_background.dart';
import 'package:look_prior/common/widgets/app_icon_button.dart';
import 'package:look_prior/common/widgets/app_bar_text_field.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_product_list.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/screens/location_screen/location_screen.dart';

import '../../common/contants/icon_constants.dart';
import '../../utils/scroll_behavior/scroll_brehavior.dart';
import '../catagory_screen/catagory_screen.dart';
import '../notification_screen/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () => dialog());
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  dialog() {
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

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        drawer: homeScreenDrawer(_scaffoldKey, mounted),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(children: [
            Container(
                height: 200,
                color: ColorConstants.appColor,
                alignment: Alignment.center,
                child: homeScreenAppBar()),
            Positioned(
                top: 170,
                bottom: 0,
                right: 0,
                left: 0,
                child: AppBackRound(
                  widget: homeScreenContent(),
                )),
          ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            backgroundColor: ColorConstants.appColor,
            onPressed: () {},
            child: const Icon(
              Icons.add,
            )),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          itemCount: 4,
          tabBuilder: (index, isActive) {
            final color = isActive ? ColorConstants.appColor : Colors.black;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  IconConstants.bottomIcon[index],
                  height: 20,
                  width: 20,
                  color: color,
                  fit: BoxFit.fill,
                ),
              ],
            );
          },
          activeIndex: activeIndex,
          onTap: (p0) {
            setState(() {
              activeIndex = p0;
            });
          },
        ));
  }

  Widget homeScreenAppBar() {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 14, right: 19, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () => (_scaffoldKey.currentState != null)
                      ? _scaffoldKey.currentState!.openDrawer()
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
                      context, CustomRoutes(child: const NotificationScreen())),
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

  Widget homeScreenDrawer(GlobalKey<ScaffoldState> scaffoldKey, bool mounted) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
                height: 133,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                color: ColorConstants.appColor,
                child: SvgPicture.asset(DrawerImgConstants.userImage)),
            SizedBox(
              height: 350,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: DrawerIconConstants.drawerIconList.length,
                itemBuilder: (context1, index) {
                  return ListTile(
                    onTap: () =>
                        drawerListOnTap(index, context, _scaffoldKey, mounted),
                    leading: AppIconButton(
                        color: ColorConstants.iconButtonColor,
                        iconName: DrawerIconConstants.drawerIconList[index]),
                    title: AppText(
                      text: StringConstants.drawerTitle[index],
                      color: ColorConstants.fontColor,
                      fontSize: 15,
                    ),
                    trailing: const Icon(Icons.navigate_next_outlined),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 170),
              child: SizedBox(
                  height: 56,
                  width: 86,
                  child: Image.asset(ImageConstants.appLogo)),
            ),
          ],
        ),
      ),
    );
  }

  Widget homeScreenContent() {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 23, bottom: 10),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: IconConstants.catagoryListIcon.length,
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
                            color: ColorConstants.catagoryListColor,
                            iconName: IconConstants.catagoryListIcon[index]),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: AppText(
                            text: StringConstants.catagoryListTitle[index],
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
            padding: const EdgeInsets.only(top: 23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  textAlign: TextAlign.start,
                  color: ColorConstants.headerColor,
                  text: StringConstants.topAds,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                AppText(
                  text: "See all >",
                  fontSize: 14,
                  color: ColorConstants.appColor,
                )
              ],
            ),
          ),
          SizedBox(
            height: 218,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: ImageConstants.topAdsList.length,
              itemBuilder: (context, index) {
                return AppProductList(
                  pictureHeight: 110,
                  pictureWidth: 150,
                  productName: StringConstants.topAdProduct[index],
                  productPrize: StringConstants.topAdProductPrize[index],
                  image: ImageConstants.topAdsList[index],
                );
              },
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ImageConstants.nearYouList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 5,
                crossAxisSpacing: 2,
                crossAxisCount: 2,
                childAspectRatio: 0.75),
            itemBuilder: (context, index) {
              return AppProductList(
                width: 100,
                pictureHeight: 110,
                pictureWidth: 140,
                paddingLeft: 10,
                image: ImageConstants.nearYouList[index],
                productName: StringConstants.nearYouProductList[index],
                productPrize: StringConstants.nearYouProductPrize[index],
              );
            },
          )
        ],
      ),
    );
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
