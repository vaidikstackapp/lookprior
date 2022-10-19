import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/contants/icon_constants.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/screens/user_details_screen/user_screen_view_model.dart';

// ignore: must_be_immutable
class UserDetailScreen extends StatefulWidget {
  GlobalKey<ScaffoldState>? scaffoldKey;

  UserDetailScreen({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => UserDetailScreenState();
}

class UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  void getData() {}
  UserScreenViewModel? userScreenViewModel;
  @override
  Widget build(BuildContext context) {
    userScreenViewModel ?? (userScreenViewModel = UserScreenViewModel(this));
    return Scaffold(
      backgroundColor: ColorConstants.appColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstants.appColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(IconConstants.editIcon),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Column(children: [
                  Container(
                    height: 200,
                    color: Colors.pink,
                  ),
                  Container(
                    height: 200,
                    color: Colors.yellow,
                  ),
                  Container(
                    height: 200,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 200,
                    color: Colors.yellow,
                  ),
                  Container(
                    height: 200,
                    color: Colors.red,
                  ),
                ]),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                    color: Colors.grey,
                  ),
                  child: Image.network(
                    'https://png.pngtree.com/element_our/png/20181206/users-vector-icon-png_260862.jpg',
                    scale: 10,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
