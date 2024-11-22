import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapsReversionProvider extends ChangeNotifier {
  static int markerCounter = 1;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  List<LatLng> points = [];
  Set<Circle> circles = {
    Circle(
      circleId: const CircleId('1'),
      center: const LatLng(30.065673283750364, 31.324755663320506),
      radius: 1000,
      visible: true,
      fillColor: Colors.redAccent.withOpacity(0.2),
      strokeColor: Colors.yellow,
      strokeWidth: 1,
    )
  };

  late GoogleMapController mapController;
  onTapGooleMap(LatLng latLng) {
    markers.add(
      Marker(
        markerId: MarkerId(markerCounter.toString()),
        position: latLng,
      ),
    );
    polylines.add(
        const Polyline(polylineId: PolylineId('1'), visible: true, points: []));
    markerCounter++;
    notifyListeners();
  }

  getCurrentLocation() async {
    bool isPermistionDone = await _checkLocationPermission();
    if (!isPermistionDone) {
      log('not permission done');
      return;
    }
    bool isServiceEnable = await _checkLocationServiceEnable();
    if (!isServiceEnable) {
      log('not isService enable done');
      return;
    }
    var position = await Geolocator.getCurrentPosition();
    printCurrentLocation(position);
    _updateUserLocation(position);
    notifyListeners();
  }

  treceLocation() {
    Geolocator.getPositionStream().listen((position) {
      points.add(LatLng(position.latitude, position.longitude));
      polylines.add(
        Polyline(
          polylineId: const PolylineId('1'),
          visible: true,
          points: points,
          color: Colors.red,
          width: 5,
        ),
      );
      printCurrentLocation(position);
      _updateUserLocation(position);
      notifyListeners();
    });
  }

  printCurrentLocation(Position position) {
    log('latitude ${position.latitude}');
    log('longitude ${position.longitude}');
    log('longitude ${position.speed}');
  }

  _updateUserLocation(Position position) {
    markers.add(
      Marker(
        infoWindow: const InfoWindow(title: 'My Location'),
        markerId: const MarkerId('my location'),
        position: LatLng(position.latitude, position.longitude),
      ),
    );
    //markerCounter++;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 17),
      ),
    );
  }

  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> _checkLocationServiceEnable() async {
    bool isServiceEnable = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnable) {
      var permission = await Permission.location.request();
      return permission.isGranted;
    }

    return isServiceEnable;
  }
}
