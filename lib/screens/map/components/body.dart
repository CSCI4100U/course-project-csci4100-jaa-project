import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                minZoom: 5,
                maxZoom: 18,
                zoom: 13,
                center: LatLng(51.5090214, -0.1982948),
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/joacotome24/clar6ybyw000j14njy9l1uv4p/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoiam9hY290b21lMjQiLCJhIjoiY2xhcjVpam5kMXB2MDN2bzVlY3EydW8xOCJ9.tiwkoeBOZnsBzRgsJxOtpQ",
                ),
              ],
            ),
          ],
        ),
    );
  }
}
