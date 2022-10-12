import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/icon_constants.dart';
import 'package:look_prior/common/widgets/app_bar.dart';
import 'package:look_prior/utils/scroll_behavior/scroll_brehavior.dart';

import '../../common/contants/color_contants.dart';
import '../../common/widgets/app_background.dart';
import '../../common/widgets/app_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
              child: CommonAppBar(
                title: "Notification",
              )),
          Positioned(
              top: 93,
              bottom: 0,
              right: 0,
              left: 0,
              child: AppBackRound(
                widget: notificationScreenContent(context),
              )),
        ]),
      ),
    );
  }
}

List<String> title = [
  "Thanks for joining the LookPrior Marketplace",
  "Your Listing is rejected fromLookPrior Marketplace",
  "Your Listing is rejected fromLookPrior Marketplace",
];

Widget notificationScreenContent(BuildContext context) {
  return ScrollConfiguration(
    behavior: MyBehavior(),
    child: ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: AppText(
            text: "Today at 06:00 AM",
            color: ColorConstants.fontColor.withOpacity(0.5),
          ),
        ),
        ListTile(
          leading: Container(
            height: 60,
            width: 60,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorConstants.appColor),
            child: Image.asset(
              fit: BoxFit.contain,
              IconConstants.appLogoWithoutColor,
              scale: 1.8,
            ),
          ),
          trailing: const Icon(Icons.more_horiz),
          subtitle: AppText(
            text: "2 days ago",
            fontSize: 11,
            color: ColorConstants.fontColor.withOpacity(0.5),
          ),
          title: AppText(
            text: "Thanks for joining the LookPrior Marketplace",
            color: ColorConstants.fontColor,
            fontSize: 12,
          ),
        ),
        ListTile(
          leading: Container(
            height: 60,
            width: 60,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorConstants.appColor),
            child: Image.asset(
              fit: BoxFit.contain,
              IconConstants.appLogoWithoutColor,
              scale: 1.8,
            ),
          ),
          trailing: const Icon(Icons.more_horiz),
          subtitle: AppText(
            text: "2 days ago",
            fontSize: 11,
            color: ColorConstants.fontColor.withOpacity(0.5),
          ),
          title: AppText(
            text: "Your Listing is rejected from LookPrior Marketplace",
            color: ColorConstants.fontColor,
            fontSize: 12,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: AppText(
            text: "Yesterday 02:00 PM",
            color: ColorConstants.fontColor.withOpacity(0.5),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: title.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                height: 60,
                width: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: ColorConstants.appColor),
                child: Image.asset(
                  fit: BoxFit.contain,
                  IconConstants.appLogoWithoutColor,
                  scale: 1.8,
                ),
              ),
              trailing: const Icon(Icons.more_horiz),
              subtitle: AppText(
                text: "2 days ago",
                fontSize: 11,
                color: ColorConstants.fontColor.withOpacity(0.5),
              ),
              title: AppText(
                text: title[index],
                color: ColorConstants.fontColor,
                fontSize: 12,
              ),
            );
          },
        )
      ],
    ),
  );
}
