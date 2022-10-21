import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_prior/common/contants/icon_constants.dart';
import 'package:look_prior/common/contants/string_contants.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_textfield.dart';
import 'package:look_prior/model/user_model.dart';
import 'package:look_prior/screens/edit_user_detail_screen/edit_user_profile_model.dart';

import '../../common/contants/color_contants.dart';
import '../../common/widgets/app_text.dart';
import '../../utils/scroll_brehavior.dart';

// ignore: must_be_immutable
class EditUserDetailScreen extends StatefulWidget {
  UserModel? userModel;

  EditUserDetailScreen({Key? key, this.userModel}) : super(key: key);

  @override
  State<EditUserDetailScreen> createState() => EditUserDetailScreenState();
}

class EditUserDetailScreenState extends State<EditUserDetailScreen> {
  EditUserModel? editUserModel;

  @override
  @override
  Widget build(BuildContext context) {
    editUserModel ?? (editUserModel = EditUserModel(this));
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
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: AppButton(
                    topPadding: 10,
                    bottomPadding: 10,
                    textColor: const Color(0xff9A9999),
                    text: "Cancel",
                    buttonColor: ColorConstants.cancelButtonColor,
                  )),
              Expanded(
                  flex: 2,
                  child: AppButton(
                    onTap: () => editUserModel!.saveOnTap(),
                    text: "Save",
                    buttonColor: ColorConstants.appColor,
                  )),
            ],
          ),
        ),
        body: editDetailContent());
  }

  Widget editDetailContent() {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AppText(
                            text: "First Name",
                            textAlign: TextAlign.start,
                            color: ColorConstants.fontSubTitleColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: AppText(
                              text: "Last Name",
                              color: ColorConstants.fontSubTitleColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              contentPadding: const EdgeInsets.all(10),
                              height: 50,
                              controller: editUserModel!.firstNameController,
                            ),
                          ),
                          Expanded(
                            child: AppTextField(
                              controller: editUserModel!.lastNameController,
                              contentPadding: const EdgeInsets.all(10),
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: DropdownButtonFormField(
                          value: editUserModel!.useType,
                          icon: SvgPicture.asset(IconConstants.dropDownIcon),
                          borderRadius: BorderRadius.circular(10),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              constraints: const BoxConstraints(maxHeight: 50),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.appColor)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          items: [
                            DropdownMenuItem(
                                value: 1,
                                child: AppText(
                                  text: "Owner",
                                  color: ColorConstants.fontColor,
                                )),
                            DropdownMenuItem(
                                value: 2,
                                child: AppText(
                                  text: "Business",
                                  color: ColorConstants.fontColor,
                                )),
                          ],
                          onChanged: (value) {
                            editUserModel!.useType = value!;
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: AppText(
                          text: "Address",
                          color: ColorConstants.fontSubTitleColor,
                        ),
                      ),
                      AppTextField(
                        contentPadding: const EdgeInsets.all(10),
                        height: 50,
                        controller: editUserModel!.addressController,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: AppText(
                          text: StringConstants.email,
                          color: ColorConstants.fontSubTitleColor,
                        ),
                      ),
                      AppTextField(
                        contentPadding: const EdgeInsets.all(10),
                        height: 50,
                        readOnly: true,
                        controller: editUserModel!.emailController,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: AppText(
                          text: "WebSite (Send people directly to your site)",
                          color: ColorConstants.fontSubTitleColor,
                        ),
                      ),
                      AppTextField(
                        contentPadding: const EdgeInsets.all(10),
                        height: 50,
                        controller: editUserModel!.websiteController,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () => openCountryPickerDialog(context),
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.4)),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      CountryPickerUtils.getDefaultFlagImage(
                                          editUserModel!.country),
                                      AppText(
                                        text:
                                            "(${editUserModel!.country.iso3Code})+${editUserModel!.country.phoneCode}",
                                        color: ColorConstants.fontColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: AppTextField(
                                contentPadding: const EdgeInsets.all(10),
                                height: 50,
                                controller: editUserModel!.phoneController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: "Public profile",
                              fontSize: 16,
                              color: ColorConstants.fontColor,
                            ),
                            Switch(
                              value: editUserModel!.isPublicProfile,
                              activeColor: ColorConstants.appColor,
                              onChanged: (value) {
                                editUserModel!.isPublicProfile = value;
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: "Public Email",
                              fontSize: 16,
                              color: ColorConstants.fontColor,
                            ),
                            Switch(
                              value: editUserModel!.isPublicEmail,
                              activeColor: ColorConstants.appColor,
                              onChanged: (value) {
                                editUserModel!.isPublicEmail = value;
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                widget.userModel!.imagePath.toString())),
                        border: Border.all(
                          width: 3,
                          color: ColorConstants.white,
                        ),
                        color: ColorConstants.white),
                    child: Image.asset(
                      IconConstants.profileEditIcon,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
        (editUserModel!.isLoading)
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.transparent,
                child: const Center(child: CircularProgressIndicator()),
              )
            : const SizedBox(),
      ],
    );
  }

  void openCountryPickerDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: const EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: const InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: const Text('Select your phone code'),
            onValuePicked: (value) {
              editUserModel!.country = value;
              setState(() {});
            },
            itemBuilder: buildDialogItem,
            priorityList: [
              CountryPickerUtils.getCountryByIsoCode('TR'),
              CountryPickerUtils.getCountryByIsoCode('US'),
            ],
          ),
        ),
      );

  Widget buildDialogItem(Country country) => Padding(
        padding: const EdgeInsets.only(bottom: 13),
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            Flexible(
                child: Text(
              "(${country.name})+${country.phoneCode}",
              overflow: TextOverflow.ellipsis,
            )),
          ],
        ),
      );

  void refresh() {
    setState(() {});
  }
}
