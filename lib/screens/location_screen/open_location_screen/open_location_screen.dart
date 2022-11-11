import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:look_prior/common/widgets/app_bar.dart';
import 'package:look_prior/common/widgets/app_screen_backgroud.dart';
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
          child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                locationViewModel!.mapController.complete(controller);
              },
              markers: Set<Marker>.of(locationViewModel!.marker),
              initialCameraPosition: locationViewModel!.kGooglePlex),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
