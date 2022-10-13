import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:look_prior/common/contants/icon_constants.dart';
import 'package:look_prior/common/widgets/app_bar.dart';
import 'package:look_prior/common/widgets/app_button.dart';
import 'package:look_prior/common/widgets/app_screen_backgroud.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/common/widgets/app_textfield.dart';
import 'package:look_prior/utils/scroll_behavior/scroll_brehavior.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../common/contants/color_contants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  List<Marker> marker = [];
  List<Marker> list = [
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(37.42796133580664, -122.085749655962))
  ];

  @override
  void initState() {
    super.initState();
    marker.addAll(list);
  }

  double changedValue = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreenBackGround(
          appbarWidget: CommonAppBar(title: "Select Category"),
          bodyWidget: locationScreenContent()),
    );
  }

  //CommonAppBar(title: "Select Category")
  Widget locationScreenContent() {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shrinkWrap: true,
        children: [
          AppText(
            text: 'Catagory',
            fontSize: 14,
            color: ColorConstants.fontColor.withOpacity(0.4),
          ),
          AppTextField(
            topMargin: 14,
            contentPadding: const EdgeInsets.only(top: 10),
            leftMargin: 0,
            rightMargin: 0,
            prefixIcon: IconConstants.moreIcon,
            readOnly: true,
            suffixIcon: LocationIconConstants.moveIcon,
            hintText: "Select category",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: AppText(
              text: 'Location',
              fontSize: 14,
              color: ColorConstants.fontColor.withOpacity(0.4),
            ),
          ),
          AppTextField(
            topMargin: 10,
            contentPadding: const EdgeInsets.only(top: 10),
            leftMargin: 0,
            rightMargin: 0,
            prefixIcon: IconConstants.locationIcon,
            readOnly: true,
            suffixIcon: LocationIconConstants.editIcon,
            hintText: "California, USA",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: AppText(
              text: 'Select Distance',
              fontSize: 14,
              color: ColorConstants.fontColor.withOpacity(0.4),
            ),
          ),
          SfSlider(
            min: 50.0,
            max: 250.0,
            activeColor: ColorConstants.appColor,
            value: changedValue,
            interval: 50,
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            minorTicksPerInterval: 1,
            onChanged: (dynamic value) {
              setState(() {
                changedValue = value;
              });
            },
          ),
          Container(
            height: 190,
            margin: const EdgeInsets.only(top: 15),
            child: GoogleMap(
              myLocationEnabled: true,
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              markers: Set<Marker>.of(marker),
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          AppButton(
            topPadding: 5,
            buttonColor: ColorConstants.appColor,
            text: "Apply",
          ),
        ],
      ),
    );
  }
}
