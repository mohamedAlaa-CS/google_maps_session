import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_google_maps/map_provider.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(30.065673283750364, 31.32474493448469),
    zoom: 20,
  );
  late MapProvider mapProvider;
  @override
  void dispose() {
    super.dispose();
    mapProvider.closeTrace();
  }

  @override
  Widget build(BuildContext context) {
    log('Build Google Maps');
    mapProvider = Provider.of<MapProvider>(context);
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(
              Icons.my_location,
              color: Colors.black,
            ),
            onPressed: () {
              mapProvider.getCurrentLocation();
            },
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            child: const Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            onPressed: () {
              mapProvider.traceLocation();
            },
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapProvider.googleMapController = controller;
        },
        markers: mapProvider.markers,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
      ),
    );
  }
}
