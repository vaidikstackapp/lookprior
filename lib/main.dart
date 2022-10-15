import 'package:country_picker/country_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/screens/home_screen/home_screen.dart';
import 'package:look_prior/screens/location_screen/location_screen.dart';
import 'package:look_prior/screens/login_screen/login_screen.dart';
import 'package:look_prior/screens/register_screen/register_screen.dart';
import 'package:look_prior/screens/splesh_screen/splesh_screen.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: ColorConstants.appColor, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GestureDetector(
    onTap: () {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: "/",
      routes: {
        "/RegisterScreen": (context) => const RegisterScreen(),
        "/LoginScreen": (context) => const LogInScreen(),
        "/HomeScreen": (context) => const HomeScreen(),
        "/LocationScreen": (context) => const LocationScreen(),
      },
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('es'),
        Locale('de'),
        Locale('fr'),
        Locale('el'),
        Locale('et'),
        Locale('nb'),
        Locale('nn'),
        Locale('pl'),
        Locale('pt'),
        Locale('ru'),
        Locale('hi'),
        Locale('ne'),
        Locale('uk'),
        Locale('hr'),
        Locale('tr'),
        Locale('lv'),
        Locale('lt'),
        Locale('ku'),
        Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
        Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
      ],
      localizationsDelegates: const [
        CountryLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate
      ],
    ),
  ));
}
