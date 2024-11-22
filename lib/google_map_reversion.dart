import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_google_maps/google_maps_reversion_provider.dart';

// ignore: must_be_immutable
class GoogleMapsReversion extends StatelessWidget {
  static const routeName = '/google_maps_reversion';
  GoogleMapsReversion({super.key});
  var intialCameraPostion = const CameraPosition(
    target: LatLng(30.065673283750364, 31.324755663320506),
    zoom: 14,
  );
  @override
  Widget build(BuildContext context) {
    var pr = Provider.of<GoogleMapsReversionProvider>(context);

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              pr.getCurrentLocation();
            },
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              pr.treceLocation();
            },
            child: const Icon(Icons.location_on),
          ),
        ],
      ),
      body: GoogleMap(
        // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
        //     northeast: const LatLng(30.06839383618889, 31.31976675466598),
        //     southwest: const LatLng(30.063491216660584, 31.329133028333512))),
        onMapCreated: (controller) {
          pr.mapController = controller;
        },
        zoomControlsEnabled: false,
        circles: pr.circles,
        polylines: pr.polylines,
        markers: pr.markers,
        compassEnabled: false,
        mapType: MapType.normal,
        onTap: pr.onTapGooleMap,
        initialCameraPosition: intialCameraPostion,
      ),
    );
  }
}
