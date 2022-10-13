import 'package:flutter/material.dart';
import 'package:look_prior/common/contants/string_contants.dart';
import 'package:look_prior/common/widgets/app_bar.dart';
import 'package:look_prior/common/widgets/app_screen_backgroud.dart';

class AdDetailScreen extends StatefulWidget {
  const AdDetailScreen({Key? key}) : super(key: key);

  @override
  State<AdDetailScreen> createState() => _AdDetailScreenState();
}

class _AdDetailScreenState extends State<AdDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreenBackGround(
        appbarWidget: CommonAppBar(title: StringConstants.postAd),
      ),
    );
  }
}
