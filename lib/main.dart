import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_google_maps/google_map_reversion.dart';
import 'package:test_google_maps/google_maps.dart';
import 'package:test_google_maps/google_maps_reversion_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GoogleMapsReversionProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/google_maps': (context) => const GoogleMaps(),
        GoogleMapsReversion.routeName: (context) => GoogleMapsReversion(),
      },
      home: GoogleMapsReversion(),
    );
  }
}
