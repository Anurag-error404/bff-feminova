import 'dart:async';
import 'package:feminova/app/colors.dart';
import 'package:feminova/widgets/carousal.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(28.7041, 77.1025),
            zoom: 9.2,
          ),
          nonRotatedChildren: [
            AttributionWidget.defaultWidget(
              source: 'OpenStreetMap contributors',
              onSourceTapped: null,
            ),
          ],
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(28.7041, 77.1025),
                  width: 80,
                  height: 80,
                  builder: (context) => Icon(Icons.wash),
                ),
                Marker(
                  point: LatLng(28.841, 77.325),
                  width: 80,
                  height: 80,
                  builder: (context) => Icon(Icons.wash),
                ),
                Marker(
                  point: LatLng(28.641, 77.25),
                  width: 80,
                  height: 80,
                  builder: (context) => Icon(Icons.wash),
                ),
                Marker(
                  point: LatLng(28.803, 77.1125),
                  width: 80,
                  height: 80,
                  builder: (context) => Icon(Icons.wash),
                ),
                Marker(
                  point: LatLng(28.885, 77.225),
                  width: 80,
                  height: 80,
                  builder: (context) => Icon(Icons.wash),
                ),
                Marker(
                  point: LatLng(28.103, 77.1085),
                  width: 80,
                  height: 80,
                  builder: (context) => Icon(Icons.wash),
                ),
                Marker(
                  point: LatLng(28.7641, 77.1005),
                  width: 80,
                  height: 80,
                  builder: (context) => Icon(Icons.wash),
                ),
                // Marker(
                //   point: LatLng(27.7041, 74.1025),
                //   width: 80,
                //   height: 80,
                //   builder: (context) => Icon(Icons.wash),
                // ),
                // Marker(
                //   point: LatLng(23.7041, 74.1025),
                //   width: 80,
                //   height: 80,
                //   builder: (context) => Icon(Icons.wash),
                // ),
                // Marker(
                //   point: LatLng(21.7041, 79.1025),
                //   width: 80,
                //   height: 80,
                //   builder: (context) => Icon(Icons.wash),
                // ),
              ],
            ),
            // children: [
        // PolygonLayer(
        //     polygonCulling: false,
        //     polygons: [
        //         Polygon(
        //           points: [LatLng(30, 40), LatLng(20, 50), LatLng(25, 45),],
        //           color: Colors.blue,
        //         ),
        //     ],
        // ),
    ],
          // ],
        ),
        AppCarousalSlider(
          height: 150,
          isCenterBig: false,
          carouselItems: [
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    AppColor.accentMain,
                    AppColor.accentMainDark,
                  ],
                ),
              ),
              child: Column(children: [
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Nawada, Delhi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  "Mansa Rama park, Dwarka Mor, New Delhi - 59",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    AppColor.accentMain,
                    AppColor.accentMainDark,
                  ],
                ),
              ),
              child: Column(children: [
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Nawada, Delhi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  "Mansa Rama park, Dwarka Mor, New Delhi - 59",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    AppColor.accentMain,
                    AppColor.accentMainDark,
                  ],
                ),
              ),
              child: Column(children: [
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Dwarka sec-12, Delhi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  "City Center , Dwarka City Center Near Metro Station, New Delhi - 58",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    AppColor.accentMain,
                    AppColor.accentMainDark,
                  ],
                ),
              ),
              child: Column(children: [
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Huaz Khass Village, Delhi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  "South Ex, Hauz Khass, New Delhi - 09",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
          ],
        )
      ],
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
