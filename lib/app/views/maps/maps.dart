import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

//ke provider "maps_provider.dart"
import '../../view_model/maps_provider.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {
  final Completer<GoogleMapController> _controller = Completer();

  CameraPosition initialLocation() {
    if (mounted) {
      final location = Provider.of<MyLocation>(context, listen: false);
      return CameraPosition(
        target: _latLng ?? LatLng(location.lat, location.long),
        zoom: 17,
      );
    }
    return CameraPosition(
      target: _latLng ?? const LatLng(0, 0),
      zoom: 17,
    );
  }

  Future<void> currentPosition() async {
    if (mounted) {
      final GoogleMapController controller = await _controller.future;
      controller
          .animateCamera(CameraUpdate.newCameraPosition(initialLocation()));
    }
  }

  Marker getMarker() {
    final location = Provider.of<MyLocation>(context, listen: false);
    return Marker(
      markerId: const MarkerId("MyMarket"),
      infoWindow: const InfoWindow(title: "Your Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: _latLng ?? LatLng(location.lat, location.long),
    );
  }

  LatLng? _latLng;
  String? _address;
  String? _kodePos;

  Future<void> getAddress(double lat, double lng) async {
    if (mounted) {
      List<Placemark> placemark = await placemarkFromCoordinates(lat, lng);
      Placemark place = placemark[0];

      _address =
          "${place.street} ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      _kodePos = "Kode Pos: ${place.postalCode}";
    }
  }

  @override
  void initState() {
    final location = Provider.of<MyLocation>(context, listen: false);
    getAddress(location.lat, location.long);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = Provider.of<MyLocation>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          heroTag: "current",
          onPressed: () {
            _latLng = null;
            _address = null;
            currentPosition();
            setState(() {});
          },
          child: const Icon(
            Icons.my_location_rounded,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: [
            GoogleMap(
              onCameraMove: (cam) {
                _latLng = LatLng(cam.target.latitude, cam.target.longitude);
                getMarker();
                setState(() {});
              },
              onCameraIdle: () {
                Future.wait([
                  currentPosition(),
                  getAddress(
                    _latLng?.latitude ?? location.lat,
                    _latLng?.longitude ?? location.long,
                  )
                ]);
              },
              mapType: MapType.hybrid,
              markers: {getMarker()},
              initialCameraPosition: initialLocation(),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Align(
              alignment: const Alignment(0, 0.75),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    _address ?? _address.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(_kodePos ?? "Kode Pos: " + location.getPostCode),
                ]),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.95),
              child: FloatingActionButton.extended(
                heroTag: "save",
                onPressed: () {
                  location.setLocation = _address!;
                  location.setPostCode = _kodePos!;
                  Navigator.pop(context);
                },
                label: const Text(
                  "Simpan Lokasi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}