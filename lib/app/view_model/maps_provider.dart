import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation with ChangeNotifier {
  String _address = "Address";
  String _postCode = "00000";
  double lat = -7.2545265;
  double long = 112.7475898;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddress() async {
    Position position = await determinePosition();
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];

    _address =
        "${place.street} ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
    _postCode = "Kode Pos: ${place.postalCode}";
    lat = position.latitude;
    long = position.longitude;
    notifyListeners();
  }

  set setLocation(String val) {
    _address = val;
    notifyListeners();
  }

  set setPostCode(String val) {
    _postCode = val;
    notifyListeners();
  }

  String get getLocation => _address;
  String get getPostCode => _postCode;
}