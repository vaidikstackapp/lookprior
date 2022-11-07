import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/contants/string_contants.dart';
import 'package:look_prior/common/widgets/app_bar.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_screen_backgroud.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/common/widgets/app_textfield.dart';
import 'package:look_prior/screens/post_ad_screen/post_ad_details_screen/post_ad_details_view_model.dart';

import '../../../utils/scroll_brehavior.dart';

// ignore: must_be_immutable
class AdDetailScreen extends StatefulWidget {
  List<XFile> imagePath;
  List<XFile> videoPath;
  AdDetailScreen(this.imagePath, this.videoPath, {Key? key}) : super(key: key);

  @override
  State<AdDetailScreen> createState() => AdDetailScreenState();
}

class AdDetailScreenState extends State<AdDetailScreen> {
  PostAdDetailViewModel? detailViewModel;

  @override
  Widget build(BuildContext context) {
    detailViewModel ?? (detailViewModel = PostAdDetailViewModel(this));
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: AppButton(
          text: "Post Ad",
          onTap: () => detailViewModel!.postAdButtonOnTap(),
          fontWeight: FontWeight.bold,
          fontSize: 16,
          bottomPadding: 10,
          topPadding: 10,
          buttonColor: ColorConstants.appColor,
        ),
      ),
      body: AppScreenBackGround(
        appbarWidget: CommonAppBar(title: StringConstants.postAd),
        bodyWidget: adDetailContent(),
      ),
    );
  }

  Widget adDetailContent() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Card(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: Form(
                    key: detailViewModel!.key,
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      children: [
                        AppText(
                          text: "Ad Details",
                          fontSize: 18,
                          color: ColorConstants.fontColor,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AppText(
                          text: "Title",
                          fontSize: 16,
                          color: ColorConstants.fontColor.withOpacity(0.4),
                        ),
                        AppTextField(
                          topMargin: 14,
                          controller: detailViewModel!.titleController,
                          contentPadding:
                              const EdgeInsets.only(top: 10, left: 10),
                          leftMargin: 0,
                          rightMargin: 0,
                          hintText: "Title",
                          validator: (value) =>
                              detailViewModel!.titleValidator(value),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text: "Amount",
                          fontSize: 16,
                          color: ColorConstants.fontColor.withOpacity(0.4),
                        ),
                        AppTextField(
                          topMargin: 14,
                          contentPadding:
                              const EdgeInsets.only(top: 10, left: 10),
                          leftMargin: 0,
                          rightMargin: 0,
                          keyboardType: TextInputType.phone,
                          hintText: "Amount (\$)",
                          controller: detailViewModel!.amountController,
                          validator: (value) =>
                              detailViewModel!.amountValidator(value),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text: "Description",
                          fontSize: 14,
                          color: ColorConstants.fontColor.withOpacity(0.4),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppTextField(
                          topMargin: 5,
                          leftMargin: 0,
                          rightMargin: 0,
                          maxLines: 5,
                          hintText: "Description",
                          controller: detailViewModel!.descriptionController,
                          validator: (value) =>
                              detailViewModel!.descriptionValidator(value),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // AppText(
                        //   text: "Select Category",
                        //   fontSize: 14,
                        //   color: ColorConstants.fontColor.withOpacity(0.4),
                        // ),
                        // AppTextField(
                        //   topMargin: 14,
                        //   contentPadding: const EdgeInsets.only(top: 10, left: 10),
                        //   leftMargin: 0,
                        //   rightMargin: 0,
                        //   readOnly: true,
                        //   suffixIcon: IconConstants.dropDownIcon,
                        //   hintText: "Select Category",
                        // ),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
        (detailViewModel!.isLoading)
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.transparent,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
