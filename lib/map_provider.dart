import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapProvider extends ChangeNotifier {
  late GoogleMapController googleMapController;

  Set<Marker> markers = {};

  getCurrentLocation() async {
    bool isPermissionGranted = await _checkLocationPermission();
    if (!isPermissionGranted) {
      log('location permission not granted');
      return;
    }

    bool isServiceEnabled = await _checkLocationSeviceEnabled();
    if (!isServiceEnabled) {
      log('location service not enabled');
      return;
    }

    var position = await Geolocator.getCurrentPosition();
    printLocation(position);
    updateUserLocation(position);
    notifyListeners();
  }

  traceLocation() {
    Geolocator.getPositionStream().listen((position) {
      printLocation(position);
      updateUserLocation(position);
      notifyListeners();
    });
  }

  printLocation(Position position) {
    log('latitude: ${position.latitude}');
    log('longitude: ${position.longitude}');
    log('speedd: ${position.speed} ');
  }

  Future<bool> _checkLocationPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> _checkLocationSeviceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      var permission = await Permission.location.request();
      return permission.isGranted;
    }
    return serviceEnabled;
  }

  void updateUserLocation(Position position) {
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 17,
        ),
      ),
    );
    // markers.add(
    //   Marker(
    //     infoWindow: const InfoWindow(title: 'Route Academy'),
    //     markerId: const MarkerId('1'),
    //     position: LatLng(position.latitude, position.longitude),
    //   ),
    // );
  }

  closeTrace() {
    googleMapController.dispose();
  }
}
