import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/images_contants.dart';
import 'package:look_prior/screens/login_screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
