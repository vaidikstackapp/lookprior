import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OpenLocationScreen extends StatefulWidget {
  const OpenLocationScreen({Key? key}) : super(key: key);

  @override
  State<OpenLocationScreen> createState() => _OpenLocationScreenState();
}

class _OpenLocationScreenState extends State<OpenLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.1702, 72.8311),
    zoom: 14.4746,
  );
  List<Marker> marker = [];
  List<Marker> list = [
    const Marker(markerId: MarkerId('1'), position: LatLng(21.1702, 72.8311))
  ];
  @override
  void initState() {
    super.initState();
    marker.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          print("controller---->$_controller");
        },
        markers: Set<Marker>.of(marker),
        initialCameraPosition: _kGooglePlex);
  }
}
