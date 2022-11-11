import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:look_prior/screens/location_screen/location_screen.dart';
import 'package:look_prior/utils/share_preference.dart';

class LocationScreenViewModel {
  LocationScreenState locationScreenState;

  LocationScreenViewModel(this.locationScreenState) {
    getAddressAndLocation();
  }

  CameraPosition? kGooglePlex;
  List<Marker> marker = [];
  List<Marker> markerList = [];
  final Completer<GoogleMapController> controller = Completer();
  String? getAddress;
  double? getLatitude;
  double? getLongitude;

  bool isLoading = false;

  Future<void> getAddressAndLocation() async {
    isLoading = true;
    locationScreenState.refresh();
    getAddress = await getPrefStringValue(address) ?? "Ahmedabad,India";
    getLatitude = await getPrefDoubleValue(latitude) ?? 23.0225;
    getLongitude = await getPrefDoubleValue(longitude) ?? 72.5714;
    LatLng latLng = LatLng(getLatitude!, getLongitude!);
    kGooglePlex = CameraPosition(
      target: latLng,
      zoom: 14.4746,
    );
    markerList = [
      Marker(
          markerId: const MarkerId('1'),
          position: LatLng(getLatitude!, getLongitude!))
    ];
    marker.addAll(markerList);
    isLoading = false;
    locationScreenState.refresh();
  }
}
