import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/contants/icon_constants.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/model/user_model.dart';
import 'package:look_prior/screens/edit_user_detail_screen/edit_user_detail_screen.dart';
import 'package:look_prior/screens/user_details_screen/user_screen_view_model.dart';
import 'package:look_prior/utils/scroll_brehavior.dart';

import '../../common/contants/images_contants.dart';

// ignore: must_be_immutable
class UserDetailScreen extends StatefulWidget {
  GlobalKey<ScaffoldState>? scaffoldKey;

  UserDetailScreen({Key? key, this.scaffoldKey}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => UserDetailScreenState();
}

class UserDetailScreenState extends State<UserDetailScreen> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
  }

  UserScreenViewModel? userScreenViewModel;

  @override
  Widget build(BuildContext context) {
    userScreenViewModel ?? (userScreenViewModel = UserScreenViewModel(this));
    return Scaffold(
      backgroundColor: (userScreenViewModel!.status)
          ? ColorConstants.white
          : ColorConstants.appColor,
      appBar: userScreenAppBar(),
      body: userScreenBody(),
    );
  }

  //------------------userScreenBody---------------------------------

  Widget userScreenBody() {
    return Stack(
      children: [
        ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(shrinkWrap: true, children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: ColorConstants.containerBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: SizedBox(
                      child: (userModel == null)
                          ? const SizedBox()
                          : Column(children: [
                              const SizedBox(
                                height: 60,
                              ),
                              AppText(
                                text: userModel!.userName,
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: ColorConstants.fontColor,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              AppText(
                                text: "Owner",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.4),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    IconConstants.locationIcon,
                                    height: 9.17,
                                    width: 7.79,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AppText(
                                    text: "California, USA",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              AppText(
                                text: "Video Storgae: 1 GB of 1 GB",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: ColorConstants.fontColor,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  AppText(
                                    text: "My Ads",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstants.fontColor,
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 13),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      AppText(
                                        textAlign: TextAlign.center,
                                        text: "Post something for sale today",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: ColorConstants.fontColor,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 70,
                                        width: 70,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          UserImgConstants.recordWithPhone,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      AppText(
                                        textAlign: TextAlign.center,
                                        text: "Record it with your phone",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: ColorConstants.fontColor,
                                      ),
                                      Container(
                                        height: 100,
                                        width: 200,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          UserImgConstants.takePhoto,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      AppText(
                                        textAlign: TextAlign.center,
                                        text: "Take a photo of it",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: ColorConstants.fontColor,
                                      ),
                                      Container(
                                        height: 100,
                                        width: 200,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          UserImgConstants.meetBuyer,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      AppText(
                                        textAlign: TextAlign.center,
                                        text: "Meet Buyers",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: ColorConstants.fontColor,
                                      ),
                                      Container(
                                        height: 100,
                                        width: 200,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          UserImgConstants.makeMoney,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      AppText(
                                        textAlign: TextAlign.center,
                                        text: "Make Money",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: ColorConstants.fontColor,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            ])),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          color: ColorConstants.white,
                        ),
                        color: ColorConstants.white),
                    child: (userModel == null)
                        ? Image.asset(
                            ImageConstants.user,
                            scale: 5.2,
                          )
                        : Image.network(
                            '${userModel!.imagePath}',
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            scale: 4.5,
                          ),
                  ),
                ),
              ],
            ),
          ]),
        ),
        (userScreenViewModel!.status)
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox(),
      ],
    );
  }

//------------------userScreenAppBar---------------------------------
  AppBar userScreenAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: ColorConstants.appColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: (userScreenViewModel!.status)
            ? null
            : () {
                if (widget.scaffoldKey!.currentState != null) {
                  widget.scaffoldKey!.currentState!.openDrawer();
                }
              },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SvgPicture.asset(IconConstants.drawerIcon),
        ),
      ),
      title: AppText(
        text: "Profile",
      ),
      actions: [
        GestureDetector(
          onTap: (userScreenViewModel!.status) ? null : () {},
          // : () => Navigator.push(
          //     context, CustomRoutes(child: const EditUserDetailScreen())),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(IconConstants.editIcon),
          ),
        ),
        GestureDetector(
          onTap: (userScreenViewModel!.status) ? null : () => bottomSheet(),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert_rounded),
          ),
        ),
      ],
    );
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  bottomSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 100,
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: AppText(
                          text: "Are you sure you want to log out?",
                          color: ColorConstants.fontColor,
                        ),
                        actions: [
                          GestureDetector(
                              onTap: () => userScreenViewModel!.logoutOnTap(),
                              child: AppText(
                                text: "Yes",
                                fontSize: 16,
                                color: ColorConstants.appColor,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: AppText(
                                fontSize: 16,
                                text: "No",
                                color: ColorConstants.appColor,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      );
                    },
                  );
                },
                child: SizedBox(
                  width: double.infinity,
                  child: AppText(
                    textAlign: TextAlign.center,
                    text: "Log Out",
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: ColorConstants.fontColor,
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () => userScreenViewModel!.changePasswordOnTap(context),
                child: SizedBox(
                  width: double.infinity,
                  child: AppText(
                    textAlign: TextAlign.center,
                    text: "Change password",
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: ColorConstants.fontColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
