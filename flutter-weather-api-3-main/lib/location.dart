import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  late double latitude;
  late double longitude;

  Future<dynamic> getCurrentLocation() async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      latitude = currentPosition.latitude;
      longitude = currentPosition.longitude;

      debugPrint(latitude.toString());
      debugPrint(longitude.toString());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
