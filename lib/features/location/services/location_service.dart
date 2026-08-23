import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please enable GPS.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  static Future<String> getCityName(double lat, double lon) async {
    try {
      final Geocoding geocoding = Geocoding();
      List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        lat,
        lon,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        String area = place.subLocality ?? '';
        String city = place.locality ?? place.administrativeArea ?? '';

        if (area.isNotEmpty && city.isNotEmpty) {
          return '$city, $area.';
        } else if (city.isNotEmpty) {
          return city;
        } else {
          return 'Unknown Location';
        }
      }
      return 'Unknown Location';
    } catch (e) {
      return 'Unknown Location';
    }
  }
}
