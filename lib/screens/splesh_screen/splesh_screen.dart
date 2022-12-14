import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/images_contants.dart';
//import 'package:look_prior/screens/home_screen/home_screen.dart';
import 'package:look_prior/screens/login_screen/login_screen.dart';
import 'package:look_prior/screens/manage_screen/screens.dart';
import 'package:look_prior/service/rest_service.dart';
import 'package:look_prior/utils/share_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool login = false;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then(
      (token) {
        RestServiceConstants.deviceToken = token;
      },
    );
  }

  Future<bool> checkLogin() async {
    bool login = await getPrefBoolValue(isLogin) ?? false;
    return login;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: StreamBuilder(
        stream: checkLogin().asStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          log("snapsort----->${snapshot.data}");
          bool login = snapshot.data as bool;
          log("login----->$login");
          return AnimatedSplashScreen(
              splashIconSize: 100,
              splash: ImageConstants.appLogo,
              nextScreen: (login) ? const Screens() : const LogInScreen());
        },
      ),
    ));
  }
}
