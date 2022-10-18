import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/images_contants.dart';
import 'package:look_prior/screens/home_screen/home_screen.dart';
import 'package:look_prior/screens/login_screen/login_screen.dart';
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
        log("deviceToken----------------->${RestServiceConstants.deviceToken}");
      },
    );
    checkLogin();
  }

  Future<void> checkLogin() async {
    login = await getPrefBoolValue(isLogin) ?? false;
    log("login----->$login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: AnimatedSplashScreen(
          splashIconSize: 100,
          splash: ImageConstants.appLogo,
          nextScreen: (login) ? const HomeScreen() : const LogInScreen()),
    ));
  }
}
