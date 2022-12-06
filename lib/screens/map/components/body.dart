import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/screens/details/details_screen.dart';
import 'package:course_project/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/db_models/event_model.dart';
import '../../../models/entities/event.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final MapController mapController = MapController();
  LatLng _currentLocation = LatLng(0.0, 0.0);
  int selectedIndex = 0;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition().then((position) {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: FutureBuilder(
        future: EventModel().getAllEvents(withLocation: true),
        builder: (context, snapshot) => snapshot.hasData
        ? Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  minZoom: 5,
                  maxZoom: 18,
                  zoom: 13,
                  center: _currentLocation,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/joacotome24/clar6ybyw000j14njy9l1uv4p/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoiam9hY290b21lMjQiLCJhIjoiY2xhcjVpam5kMXB2MDN2bzVlY3EydW8xOCJ9.tiwkoeBOZnsBzRgsJxOtpQ",
                  ),
                  MarkerLayerOptions(
                    markers: [
                      for (var event in snapshot.data as List<Event>)
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(event.location!.latitude,
                              event.location!.longitude),
                          builder: (_) {
                            return GestureDetector(
                              onTap: () {
                                pageController.animateToPage(
                                  snapshot.data!.indexOf(event),
                                  duration:
                                      const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                                setState(() {
                                  _currentLocation = LatLng(
                                      event.location!.latitude,
                                      event.location!.longitude);
                                  selectedIndex =
                                      snapshot.data!.indexOf(event);
                                });
                                mapController.move(_currentLocation, 11.5);
                              },
                              child: AnimatedScale(
                                duration: const Duration(milliseconds: 500),
                                scale: selectedIndex ==
                                        snapshot.data!.indexOf(event)
                                    ? 1
                                    : 0.7,
                                child: AnimatedOpacity(
                                  duration:
                                      const Duration(milliseconds: 500),
                                  opacity: selectedIndex ==
                                          snapshot.data!.indexOf(event)
                                      ? 1
                                      : 0.5,
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 2,
                height: MediaQuery.of(context).size.height * 0.2,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (value) {
                    _currentLocation = LatLng(
                        snapshot.data![value].location!.latitude,
                        snapshot.data![value].location!.longitude);
                    mapController.move(_currentLocation, 11.5);
                    selectedIndex = value;
                    setState(() {});
                  },
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    final item = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () async => {
                          Navigator.pushNamed(
                            context,
                            DetailsScreen.routeName,
                            arguments: EventDetailsArguments(event: item),
                          )
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: const Color.fromARGB(255, 30, 29, 29),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          /// text description made scrollable
                                          /// for when it is too long
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Text(
                                                item.description,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      item.images!.isNotEmpty
                                          ? item.images!.first
                                          : 'assets/images/No_image_available.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )
        : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
