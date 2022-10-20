import 'package:flutter/material.dart';
import 'package:look_prior/common/widgets/app_textfield.dart';

import '../../common/contants/color_contants.dart';
import '../../common/widgets/app_text.dart';
import '../../utils/scroll_brehavior.dart';

class EditUserDetailScreen extends StatefulWidget {
  const EditUserDetailScreen({Key? key}) : super(key: key);

  @override
  State<EditUserDetailScreen> createState() => _EditUserDetailScreenState();
}

class _EditUserDetailScreenState extends State<EditUserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.appColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorConstants.appColor,
          elevation: 0,
          title: AppText(
            text: "Profile",
          ),
        ),
        body: Stack(
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
                          child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: AppText(
                                  text: "First Name",
                                  color: ColorConstants.fontSubTitleColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 50),
                                child: AppText(
                                  text: "First Name",
                                  color: ColorConstants.fontSubTitleColor,
                                ),
                              )
                            ],
                          ),
                          AppTextField(
                            topMargin: 15,
                            hintTextSize: 13,
                            height: 50,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          AppTextField(
                            topMargin: 15,
                            hintTextSize: 13,
                            height: 50,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          AppTextField(
                            topMargin: 15,
                            hintTextSize: 13,
                            height: 50,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      )),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 3,
                                color: ColorConstants.white,
                              ),
                              color: ColorConstants.white),
                          child: AppText(
                            text: "helllo",
                            color: ColorConstants.appColor,
                          )),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ));
  }
}
