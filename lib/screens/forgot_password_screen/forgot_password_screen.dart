import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/contants/string_contants.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/screens/forgot_password_screen/forgot_password_view_model.dart';
import 'package:look_prior/utils/scroll_behavior.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => ForgotPassScreenState();
}

class ForgotPassScreenState extends State<ForgotPassScreen> {
  ForgotPassViewModel? forgotPassViewModel;

  @override
  Widget build(BuildContext context) {
    forgotPassViewModel ?? (forgotPassViewModel = ForgotPassViewModel(this));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              children: [
                AppBar(
                  leading: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                    ),
                  ),
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: AppText(
                    text: "FORGOT PASSWORD",
                    fontSize: 18,
                    color: ColorConstants.fontColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                AppText(
                  color: ColorConstants.subTitleColor,
                  text: StringConstants.forgotPass,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: forgotPassViewModel!.emailController,
                    cursorColor: ColorConstants.appColor,
                    decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorConstants.appColor)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        errorText: (forgotPassViewModel!.error)
                            ? "Enter your email"
                            : null,
                        label: AppText(
                          text: StringConstants.email,
                          color: ColorConstants.fontColor,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                AppButton(
                  onTap: () => forgotPassViewModel!.forgotPassOnTap(context),
                  text: "Send",
                  fontSize: 18,
                  buttonColor: ColorConstants.appColor,
                ),
              ],
            ),
          ),
          (forgotPassViewModel!.status)
              ? Center(
                  child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ))
              : const SizedBox(),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
