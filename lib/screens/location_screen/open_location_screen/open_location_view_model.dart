import 'dart:async';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:look_prior/common/widgets/app_toast.dart';
import 'package:look_prior/screens/location_screen/open_location_screen/open_location_screen.dart';
import 'package:look_prior/utils/handel_permission/location_permission.dart';
import 'package:look_prior/utils/share_preference.dart';

class OpenLocationViewModel {
  OpenLocationScreenState locationScreenState;

  OpenLocationViewModel(this.locationScreenState) {
    marker.addAll(markerList);
    getCurrentLocation();
  }

  final Completer<GoogleMapController> mapController = Completer();
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(23.0225, 72.5714),
    zoom: 20.4746,
  );

  List<Marker> marker = [];
  List<Marker> markerList = [
    const Marker(markerId: MarkerId('1'), position: LatLng(23.0225, 72.5714))
  ];
  String? currentLocationAddress = 'Ahmedabad,India';
  Position? getCurrentPosition;

  Future<void> getCurrentLocation() async {
    final handlePermission = await PermissionHandler.handleLocationPermission();
    if (!handlePermission) {
      return;
    }
    try {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        getCurrentPosition = position;
        log('latitude----->${getCurrentPosition!.latitude}');
        log('longitude----->${getCurrentPosition!.longitude}');

        getCurrentLocationAddress(getCurrentPosition);
        GoogleMapController controller = await mapController.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            zoom: 20.4746,
            target: LatLng(
                getCurrentPosition!.latitude, getCurrentPosition!.longitude))));
        markerList = [
          Marker(
              markerId: const MarkerId('1'),
              position: LatLng(
                  getCurrentPosition!.latitude, getCurrentPosition!.longitude))
        ];
        marker.addAll(markerList);
        if (locationScreenState.mounted) {
          locationScreenState.refresh();
        }
      });
    } on LocationServiceDisabledException catch (e) {
      log("catch error--->$e");
      setPrefDoubleValue(latitude, 23.0225);
      setPrefDoubleValue(longitude, 72.5714);
      setPrefStringValue(address, "Ahmedabad,India");
      appToast("$e");
    }
  }

  Future<void> getCurrentLocationAddress(Position? getCurrentPosition) async {
    try {
      if (getCurrentPosition != null) {
        await placemarkFromCoordinates(
                getCurrentPosition.latitude, getCurrentPosition.longitude)
            .then(
          (List<Placemark> placeMark) async {
            Placemark place = placeMark[0];
            currentLocationAddress =
                "${place.subAdministrativeArea},${place.country}";
            setPrefDoubleValue(latitude, getCurrentPosition.latitude);
            setPrefDoubleValue(longitude, getCurrentPosition.longitude);
            setPrefStringValue(address, currentLocationAddress);
            locationScreenState.refresh();
          },
        );
      }
    } catch (e) {
      appToast("$e");
      setPrefDoubleValue(latitude, 23.0225);
      setPrefDoubleValue(longitude, 72.5714);
      setPrefStringValue(address, "Ahmedabad,India");
      log("catch exception for getCurrentLocationAddress----$e");
    }
  }
}
