import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
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
    lat = 23.0225;
    long = 72.5714;
  }

  double? lat;
  double? long;
  final Completer<GoogleMapController> mapController = Completer();
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(23.0225, 72.5714),
    zoom: 14.4746,
  );

  List<Marker> marker = [];
  List<Marker> markerList = [
    const Marker(markerId: MarkerId('1'), position: LatLng(23.0225, 72.5714))
  ];
  String? currentLocationAddress = 'Ahmedabad,India';
  Position? getCurrentPosition;

  //------------get current location--------------
  Future<void> getCurrentLocation() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final handlePermission = await PermissionHandler.handleLocationPermission();
    print("handlepermission--->$handlePermission");
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

        convertLayLongToAddress(
            getCurrentPosition!.latitude, getCurrentPosition!.longitude);
        controllerMapCameraPosition(
            getCurrentPosition!.latitude, getCurrentPosition!.longitude);
        // GoogleMapController controller = await mapController.future;
        // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        //     zoom: 14.4746,
        //     target: LatLng(
        //         getCurrentPosition!.latitude, getCurrentPosition!.longitude))));
        // markerList = [
        //   Marker(
        //       markerId: const MarkerId('1'),
        //       position: LatLng(
        //           getCurrentPosition!.latitude, getCurrentPosition!.longitude))
        // ];
        // marker.addAll(markerList);
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

  //-----------convert current location latLong to address------------
  Future<void> convertLayLongToAddress(double lat, double long) async {
    try {
      await placemarkFromCoordinates(lat, long).then(
        (List<Placemark> placeMark) async {
          Placemark place = placeMark[0];
          currentLocationAddress =
              "${place.subAdministrativeArea},${place.country}";
          print("currentLocationAddress--->$currentLocationAddress");
          setPrefDoubleValue(latitude, lat);
          setPrefDoubleValue(longitude, long);
          setPrefStringValue(address, currentLocationAddress);
          locationScreenState.refresh();
        },
      );
    } catch (e) {
      appToast("$e");
      setPrefDoubleValue(latitude, 23.0225);
      setPrefDoubleValue(longitude, 72.5714);
      setPrefStringValue(address, "Ahmedabad,India");
      log("catch exception for getCurrentLocationAddress----$e");
    }
  }

  //----------------enter address to show in map---------------
  Future<void> getAddress(String value) async {
    try {
      String query = value;
      print("query--->$query");
      List<Location> location = await locationFromAddress(query);
      print("location--->${location[0].latitude}");
      controllerMapCameraPosition(location[0].latitude, location[0].longitude);
      convertLayLongToAddress(location[0].latitude, location[0].longitude);
      if (locationScreenState.mounted) {
        locationScreenState.refresh();
      }
    } catch (e) {
      appToast("$e");
      setPrefDoubleValue(latitude, 23.0225);
      setPrefDoubleValue(longitude, 72.5714);
      setPrefStringValue(address, "Ahmedabad,India");
      log("catch exception for getAddress----$e");
    }
  }

//-----------------controller map camera & marker position----------
  Future<void> controllerMapCameraPosition(double lat, double long) async {
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(zoom: 14.4746, target: LatLng(lat, long))));
    markerList = [
      Marker(markerId: const MarkerId('1'), position: LatLng(lat, long))
    ];
    marker.addAll(markerList);
    if (locationScreenState.mounted) {
      locationScreenState.refresh();
    }
  }
}
