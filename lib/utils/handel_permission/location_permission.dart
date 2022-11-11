import 'package:geolocator/geolocator.dart';

import '../../common/widgets/app_toast.dart';

class PermissionHandler {
  static Future<bool> handleLocationPermission() async {
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      appToast("Location services are disabled. Please enable the services");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        while (true) {
          permission = await Geolocator.requestPermission();
          if (permission != LocationPermission.denied) {
            break;
          }
        }
      }
    }

    if (permission == LocationPermission.deniedForever) {
      appToast(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }

    return true;
  }
}
