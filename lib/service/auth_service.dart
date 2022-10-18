import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:look_prior/common/widgets/app_toast.dart';

class AuthService {
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );
      GoogleSignInAccount? credential = await googleSignIn.signIn();
      print("credential------->$credential");
      return credential;
    } on PlatformException catch (e) {
      log("catch exception for signInWithGoogle---->$e");
      appToast(e.code);
      return null;
    }
  }
}
