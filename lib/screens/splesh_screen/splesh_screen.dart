import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/images_contants.dart';
import 'package:look_prior/screens/login_screen/login_screen.dart';
import 'package:look_prior/service/rest_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then(
      (token) {
        RestServiceConstants.deviceToken = token;
        print(
            "deviceToken----------------->${RestServiceConstants.deviceToken}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
            splashIconSize: 100,
            splash: ImageConstants.appLogo,
            nextScreen: const LogInScreen()),
      ),
    );
  }
}
