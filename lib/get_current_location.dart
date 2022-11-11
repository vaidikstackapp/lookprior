import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentLocation extends StatefulWidget {
  const GetCurrentLocation({Key? key}) : super(key: key);

  @override
  State<GetCurrentLocation> createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {
  Future<bool> _handleLocationPermission() async {
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location services are disabled. Please enable the services')));
      }
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
        }
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')));
      }
      return false;
    }
    return true;
  }

  String? _currentAddress;
  Position? _currentPosition;

  Future<void> _getCurrentPosition() async {
    final handlePermission = await _handleLocationPermission();
    if (!handlePermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print("lat---->${_currentPosition!.latitude}");
        print("long---->${_currentPosition!.longitude}");
        _getAddressFromLatLng(_currentPosition);
      });
    }).catchError((e) {
      print("catch error--->$e");
    });
  }

  _getAddressFromLatLng(Position? currentPosition) async {
    if (currentPosition != null) {
      await placemarkFromCoordinates(
              _currentPosition!.latitude, _currentPosition!.longitude)
          .then((List<Placemark> placeMarks) {
        Placemark place = placeMarks[0];
        setState(() {
          _currentAddress =
              '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        });
      }).catchError((e) {
        debugPrint(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                  "Lat----${(_currentPosition == null) ? " " : _currentPosition!.latitude}"),
              Text(
                  "Lang----${(_currentPosition == null) ? " " : _currentPosition!.longitude}"),
              Text(
                  "Address----${(_currentAddress == null) ? " " : _currentAddress}"),
              ElevatedButton(
                  onPressed: () => _getCurrentPosition(),
                  child: const Text("get current location")),
            ],
          ),
        ),
      ),
    );
  }
}
