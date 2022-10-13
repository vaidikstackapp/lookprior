import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:look_prior/common/contants/string_contants.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_screen_backgroud.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/utils/scroll_behavior/scroll_brehavior.dart';

import '../../common/contants/color_contants.dart';
import '../../common/widgets/app_bar.dart';

class StoragePlanScreen extends StatefulWidget {
  const StoragePlanScreen({Key? key}) : super(key: key);

  @override
  State<StoragePlanScreen> createState() => _StoragePlanScreenState();
}

class _StoragePlanScreenState extends State<StoragePlanScreen> {
  List<String> posterImg = [
    "assets/images/storage_screen_image/Rectangle 718.png",
    "assets/images/storage_screen_image/Rectangle 720.png",
    "assets/images/storage_screen_image/Rectangle 723.png",
    "assets/images/storage_screen_image/Rectangle 724.png",
    "assets/images/storage_screen_image/Rectangle 727.png",
  ];
  List<Color> color = [
    const Color(0xff48B2FF),
    const Color(0xff8337FF),
    const Color(0xffFE6274),
    const Color(0xff1DCE59),
    const Color(0xffFF9A50),
  ];

  List<String> price = ["\$3", "\$5", "\$8", "\$12", "\$15"];
  List<String> storagePlan = [
    "1 GB Storage Plan",
    "2 GB Storage Plan",
    "3 GB Storage Plan",
    "4 GB Storage Plan",
    "5 GB Storage Plan"
  ];
  List<bool> selectIndex = List.filled(5, false);

  @override
  void initState() {
    super.initState();
    selectIndex[0] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreenBackGround(
        appbarWidget: CommonAppBar(title: "Increase Storage"),
        bodyWidget: storageContent(),
      ),
    );
  }

  Widget storageContent() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Expanded(
            child: Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                children: [
                  AppText(
                    text: "Current Storage Plan",
                    fontSize: 18,
                    color: ColorConstants.fontColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const Divider(),
                  AppText(
                    text: "Video Storage : 234 GB of 237 GB",
                    fontSize: 18,
                    color: ColorConstants.fontColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  AppText(
                    text: StringConstants.storageDescription,
                    color: ColorConstants.fontColor,
                    fontSize: 15,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                            childAspectRatio: 1 / 0.7,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              selectIndex = List.filled(5, false);
                              selectIndex[index] = !selectIndex[index];
                              setState(() {});
                            },
                            child: Container(
                              height: 100,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: color[index]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 70,
                                    alignment: Alignment.topCenter,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: AssetImage(posterImg[index]),
                                      //scale: 0.1,
                                    )),
                                    child: AppText(
                                      textAlign: TextAlign.center,
                                      text: price[index],
                                      fontSize: 16,
                                    ),
                                  ),
                                  AppText(
                                    text: storagePlan[index],
                                    fontSize: 12,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          (selectIndex[index])
                              ? Positioned(
                                  top: 5,
                                  right: 7,
                                  child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 2)),
                                      child: SvgPicture.asset(
                                        "assets/icons/check.svg",
                                        color: ColorConstants.checkIconColor,
                                      )),
                                )
                              : const SizedBox(),
                        ],
                      );
                    },
                  )
                ]),
          ),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AppButton(
            buttonColor: ColorConstants.appColor,
            text: "Pay",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
