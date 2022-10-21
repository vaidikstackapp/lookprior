import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/screens/change_password_screen/change_password_screen_view_model.dart';
import 'package:look_prior/utils/scroll_brehavior.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ChangePassViewModel? passViewModel;

  @override
  Widget build(BuildContext context) {
    passViewModel ?? (passViewModel = ChangePassViewModel(this));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: GestureDetector(
            onTap:
                (passViewModel!.status) ? null : () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
        elevation: 0,
        backgroundColor: ColorConstants.appColor,
        title: AppText(
          text: "Change Password",
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: ColorConstants.containerBackgroundColor,
        child: AppButton(
          onTap: (passViewModel!.status)
              ? null
              : () => passViewModel!.updatePassOnTap(context),
          text: "Update Password",
          fontSize: 18,
          buttonColor: ColorConstants.appColor,
          topPadding: 10,
          bottomPadding: 10,
        ),
      ),
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: Form(
              key: passViewModel!.passwordKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ScreenTextField(
                      hintText: "Old Password",
                      validator: (value) =>
                          passViewModel!.oldPassValidation(value),
                      textController: passViewModel!.oldPasswordController),
                  ScreenTextField(
                    hintText: "New Password",
                    validator: (value) =>
                        passViewModel!.newPassValidation(value),
                    textController: passViewModel!.newPasswordController,
                  ),
                  ScreenTextField(
                      validator: (value) =>
                          passViewModel!.confirmPassValidation(value),
                      hintText: "Confirm Password",
                      textController: passViewModel!.confirmPasswordController),
                ],
              ),
            ),
          ),
          (passViewModel!.status)
              ? const SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}

// ignore: must_be_immutable
class ScreenTextField extends StatelessWidget {
  TextEditingController? textController;
  String? hintText;
  FormFieldValidator<String>? validator;

  ScreenTextField(
      {Key? key, this.textController, this.hintText, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        validator: validator,
        obscureText: true,
        decoration: InputDecoration(
            hintText: "$hintText",
            hintStyle: const TextStyle(color: ColorConstants.fontColor),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.appColor))),
        cursorColor: ColorConstants.appColor,
        controller: textController,
      ),
    );
  }
}
