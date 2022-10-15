import 'package:flutter/material.dart';
import 'package:look_prior/common/widgets/app_bar.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_icon_button.dart';
import 'package:look_prior/common/widgets/app_screen_backgroud.dart';

import '../../common/contants/color_contants.dart';
import '../../common/widgets/app_text.dart';
import '../../utils/scroll_brehavior.dart';

class CatagoryScreen extends StatefulWidget {
  const CatagoryScreen({Key? key}) : super(key: key);

  @override
  State<CatagoryScreen> createState() => _CatagoryScreenState();
}

class _CatagoryScreenState extends State<CatagoryScreen> {
  //catagoryContent(
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreenBackGround(
        appbarWidget: CommonAppBar(
          title: "Select Catagory",
        ),
        bodyWidget: catagoryContent(),
      ),
    );
  }

  List<String> catagoryListIcon = [
    "assets/icons/catagory_icon/service.svg",
    "assets/icons/catagory_icon/community.svg",
    "assets/icons/home_screen_icon/hotel_icon.svg",
    "assets/icons/catagory_icon/yard_sales.svg",
    "assets/icons/catagory_icon/jobs.svg",
    "assets/icons/catagory_icon/auto_part.svg",
    "assets/icons/catagory_icon/children.svg",
    "assets/icons/catagory_icon/boat.svg",
    "assets/icons/catagory_icon/game.svg",
    "assets/icons/catagory_icon/music.svg",
    "assets/icons/catagory_icon/vehical.svg",
    "assets/icons/catagory_icon/Jewellery.svg",
    "assets/icons/catagory_icon/Antiques.svg",
    "assets/icons/catagory_icon/Art.svg",
    "assets/icons/catagory_icon/book.svg",
    "assets/icons/catagory_icon/auto_part.svg",
  ];
  List<String> catagoryListTitle = [
    "Service",
    "Community",
    "Real State",
    "Yard Sales",
    "Jobs",
    "Auto Parts",
    "Children",
    "Boats",
    "Games",
    "Music",
    "Vehicles",
    "Jewellery",
    "Antiques",
    "Art",
    "Books",
    "Auto Parts",
  ];

  Widget catagoryContent() {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        itemCount: catagoryListIcon.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3,
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 2),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => bottomSheet(),
            child: Card(
              child: GridTileBar(
                title: AppText(
                  color: ColorConstants.fontColor,
                  text: catagoryListTitle[index],
                  fontSize: 13,
                ),
                leading: AppIconButton(
                    color: ColorConstants.iconButtonColor,
                    iconName: catagoryListIcon[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  List<String> bottomText = [
    "Automotive",
    "Beauty & Makeup",
    "Cell Phone",
    "Computer",
    "Creative",
    "Bycycle Repair",
    "Health & Fitness",
    "Labor/Moving",
    'Legal',
    "Marine",
    "Pet Service",
  ];
  List<bool> checkClick = List.filled(12, false);
  bottomSheet() {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      )),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bottomText.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            checkClick[index] = !checkClick[index];
                            setState(() {});
                          },
                          title: AppText(
                            text: bottomText[index],
                            color: ColorConstants.fontColor,
                          ),
                          trailing: Icon(
                            Icons.check_circle_rounded,
                            color: (checkClick[index])
                                ? ColorConstants.appColor
                                : null,
                          ),
                        );
                      },
                      shrinkWrap: true,
                    ),
                    AppButton(
                      text: "Apply",
                      onTap: () => Navigator.pop(context),
                      buttonColor: ColorConstants.appColor,
                      bottomPadding: 10,
                      topPadding: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
