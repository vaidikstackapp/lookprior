import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:look_prior/screens/home_screen/home_screen.dart';
import 'package:look_prior/screens/notification_screen/notification_screen.dart';
import 'package:look_prior/screens/post_ad_screen/post_ad_screen.dart';
import 'package:look_prior/screens/user_details_screen/user_details_screen.dart';

import '../common/contants/color_contants.dart';
import '../common/contants/icon_constants.dart';
import '../common/contants/images_contants.dart';
import '../common/contants/string_contants.dart';
import '../common/widgets/app_icon_button.dart';
import '../common/widgets/app_text.dart';
import '../common/widgets/custom_route.dart';
import '../utils/scroll_brehavior.dart';
import 'login_screen/login_screen.dart';

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  int bottomBarActiveIndex = 0;

  List<Widget> screens = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(scaffoldKey: _scaffoldKey),
      const NotificationScreen(),
      UserDetailScreen(
        scaffoldKey: _scaffoldKey,
      ),
      UserDetailScreen(
        scaffoldKey: _scaffoldKey,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: ScrollConfiguration(
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
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context, CustomRoutes(child: const LogInScreen())),
                child: Container(
                    height: 133,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    color: ColorConstants.appColor,
                    child: SvgPicture.asset(DrawerImgConstants.userImage)),
              ),
              SizedBox(
                height: 350,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DrawerIconConstants.drawerIconList.length,
                  itemBuilder: (context1, index) {
                    return ListTile(
                      onTap: () => drawerListOnTap(
                          index, context, _scaffoldKey, mounted),
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
      ),
      body: screens[bottomBarActiveIndex],
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstants.appColor,
          onPressed: () => Navigator.push(
              context,
              CustomRoutes(
                  child: const PostAdScreen(), direction: AxisDirection.down)),
          child: const Icon(
            Icons.add,
          )),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        itemCount: 4,
        tabBuilder: (index, isActive) {
          final color = isActive ? ColorConstants.appColor : Colors.black;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: SvgPicture.asset(
              IconConstants.bottomIcon[index],
              color: color,
              fit: BoxFit.fill,
            ),
          );
        },
        activeIndex: bottomBarActiveIndex,
        onTap: (p0) {
          setState(() {
            bottomBarActiveIndex = p0;
          });
        },
      ),
    );
  }
}
