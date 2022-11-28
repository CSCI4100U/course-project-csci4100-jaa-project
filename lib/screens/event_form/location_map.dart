import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class LocationMap extends StatefulWidget {
  const LocationMap({super.key});
  static String routeName = "/LocationMap";
  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  @override
  Widget build(BuildContext context) {
    
    final MapController mapController = MapController();
    var currentLocation = LatLng(0, 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location on Map"),
      ),
      body: 
      FlutterMap(
        mapController: mapController,
        options: 
          MapOptions(
            minZoom: 5,
            maxZoom: 18,
            zoom: 13,
            center: currentLocation,
          ),
        layers: [
          TileLayerOptions(
            urlTemplate:
              "https://api.mapbox.com/styles/v1/joacotome24/clar6ybyw000j14njy9l1uv4p/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoiam9hY290b21lMjQiLCJhIjoiY2xhcjVpam5kMXB2MDN2bzVlY3EydW8xOCJ9.tiwkoeBOZnsBzRgsJxOtpQ",
          ),
          MarkerLayerOptions(
            markers: [],
         ),
        ],
      ),
      floatingActionButton: 
      FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          Navigator.pop(context, mapController.center);
        },
      ),
    );
  }
}