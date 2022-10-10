import 'package:flutter/material.dart';
import 'package:look_prior/common/widgets/app_icon_button.dart';

import '../../common/contants/color_contants.dart';
import '../../common/widgets/app_background.dart';
import '../../common/widgets/app_text.dart';

class CatagoryScreen extends StatefulWidget {
  const CatagoryScreen({Key? key}) : super(key: key);

  @override
  State<CatagoryScreen> createState() => _CatagoryScreenState();
}

class _CatagoryScreenState extends State<CatagoryScreen> {
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
                  onPressed: () => Navigator.pop(context),
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
                widget: catagoryContent(),
              )),
        ]),
      ),
    );
  }

  List<String> catagoryListIcon = [
    "assets/icons/catagory_icon/service.svg",
    "assets/icons/catagory_icon/community.svg",
    "assets/icons/home_screen_icon/hotel_icon.svg",
    "assets/icons/home_screen_icon/yard_sales.svg",
    "assets/icons/home_screen_icon/jobs.svg",
    "assets/icons/home_screen_icon/auto_part.svg",
    "assets/icons/home_screen_icon/children.svg",
    "assets/icons/home_screen_icon/boat.svg",
    "assets/icons/home_screen_icon/game.svg",
    "assets/icons/home_screen_icon/music.svg",
    "assets/icons/home_screen_icon/vehical.svg",
    "assets/icons/home_screen_icon/Jewellery.svg",
    "assets/icons/home_screen_icon/Antiques.svg",
    "assets/icons/home_screen_icon/Art.svg",
    "assets/icons/home_screen_icon/book.svg",
    "assets/icons/home_screen_icon/auto_part.svg",
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
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      itemCount: catagoryListIcon.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3,
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 2),
      itemBuilder: (context, index) {
        return Card(
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
        );
      },
    );
  }
}
