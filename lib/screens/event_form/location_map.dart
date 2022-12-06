import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationMap extends StatefulWidget {
  static String routeName = "/LocationMap";

  const LocationMap({super.key});

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  final MapController mapController = MapController();
  var _currentLocation = LatLng(0, 0);
  var selectedLocation = LatLng(0, 0);
  List<Marker> markers = [];
  bool firstRender = true;

  @override
  Widget build(BuildContext context) {
    if (firstRender) {
      final initialLocation =
          ModalRoute.of(context)!.settings.arguments as GeoPoint?;
      if (initialLocation != null) {
        _currentLocation = LatLng(
          initialLocation.latitude,
          initialLocation.longitude,
        );
        selectedLocation = _currentLocation;
      }
      firstRender = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location on Map"),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
            minZoom: 5,
            maxZoom: 18,
            zoom: 13,
            center: _currentLocation,
            onTap: (tapPosition, point) => setState(() {
                  selectedLocation = point;
                  markers = [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: selectedLocation,
                      builder: (ctx) =>
                          const Icon(Icons.location_pin, color: Colors.red),
                    ),
                  ];
                  mapController.move(selectedLocation, 13);
                })),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/joacotome24/clar6ybyw000j14njy9l1uv4p/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoiam9hY290b21lMjQiLCJhIjoiY2xhcjVpam5kMXB2MDN2bzVlY3EydW8xOCJ9.tiwkoeBOZnsBzRgsJxOtpQ",
          ),
          MarkerLayerOptions(
            markers: markers,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          Navigator.pop(context, selectedLocation);
        },
      ),
    );
  }
}
