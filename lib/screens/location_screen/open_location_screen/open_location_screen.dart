import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:look_prior/common/contants/color_contants.dart';
import 'package:look_prior/common/contants/icon_constants.dart';
import 'package:look_prior/common/widgets/app_bar.dart';
import 'package:look_prior/common/widgets/app_icon_button.dart';
import 'package:look_prior/common/widgets/app_screen_backgroud.dart';
import 'package:look_prior/common/widgets/app_text.dart';
import 'package:look_prior/common/widgets/custom_route.dart';
import 'package:look_prior/screens/location_screen/location_screen.dart';
import 'package:look_prior/screens/location_screen/open_location_screen/open_location_view_model.dart';

class OpenLocationScreen extends StatefulWidget {
  const OpenLocationScreen({Key? key}) : super(key: key);

  @override
  State<OpenLocationScreen> createState() => OpenLocationScreenState();
}

class OpenLocationScreenState extends State<OpenLocationScreen> {
  OpenLocationViewModel? locationViewModel;

  @override
  Widget build(BuildContext context) {
    locationViewModel ?? (locationViewModel = OpenLocationViewModel(this));
    return Scaffold(
      body: AppScreenBackGround(
        appbarWidget: CommonAppBar(
            leadingWidget: GestureDetector(
                onTap: () => Navigator.pushReplacement(
                      context,
                      CustomRoutes(child: const LocationScreen()),
                    ),
                child: const Icon(Icons.arrow_back)),
            title: "${locationViewModel!.currentLocationAddress}"),
        bodyWidget: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    locationViewModel!.mapController.complete(controller);
                  },
                  markers: Set<Marker>.of(locationViewModel!.marker),
                  initialCameraPosition: locationViewModel!.kGooglePlex),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => locationViewModel!.getCurrentLocation(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          child: Container(
                            height: 55,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AppIconButton(
                                    iconName: IconConstants.locationIcon,
                                    height: 34,
                                    width: 35,
                                    iconColor: ColorConstants.appColor,
                                    color: ColorConstants.appColor
                                        .withOpacity(0.12)),
                                AppText(
                                  textAlign: TextAlign.center,
                                  text: "Get current Location",
                                  color: ColorConstants.fontColor,
                                ),
                                Image.asset(
                                  IconConstants.currentLocationIcon,
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: Container(
                          height: 55,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            onSubmitted: (value) {
                              locationViewModel!.getAddress(value);
                            },
                            keyboardType: TextInputType.streetAddress,
                            cursorColor: ColorConstants.appColor,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  bottom: 0, top: 15, left: 15),
                              border: InputBorder.none,
                              hintText: "Enter your address",
                              hintStyle: const TextStyle(
                                  color: ColorConstants.fontColor,
                                  fontSize: 14),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, bottom: 8, right: 8),
                                child: Container(
                                    height: 34,
                                    width: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.appColor
                                            .withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Image.asset(
                                      IconConstants.keyboardIcon,
                                      height: 16,
                                      width: 20,
                                      fit: BoxFit.contain,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
