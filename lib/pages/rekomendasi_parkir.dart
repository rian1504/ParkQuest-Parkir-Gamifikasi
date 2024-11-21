import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RekomendasiParkir extends StatefulWidget {
  const RekomendasiParkir({super.key});

  @override
  State<RekomendasiParkir> createState() => _RekomendasiParkir();
}

class _RekomendasiParkir extends State<RekomendasiParkir> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  final ScrollController _scrollController = ScrollController();

  // Camera Position
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(1.1187720779636503, 104.04845573789976),
    zoom: 18,
  );

  // Card
  Widget _buildCard(String title, String status, String route) {
    return Container(
      width: 200,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Nama Parkiran
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Status
                Text(
                  status,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          // Vertical Rule
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: VerticalDivider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
          ),
          // Arrow Icon
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(CupertinoIcons.chevron_right),
                iconSize: 32,
                onPressed: () {
                  Navigator.pushNamed(context, route);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Auto Scroll Card
  void _scrollCard(int index) {
    double cardOffset = 250.0 * index;
    _scrollController.animateTo(
      cardOffset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFD858),
        title: Text(
          'Lokasi',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            CupertinoIcons.chevron_left,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Color(0xFFFFFFE5),
      body: Column(
        children: [
          // Maps
          SizedBox(
            height: 627,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initialCameraPosition,
              markers: {
                // Parkiran GU
                Marker(
                  markerId: MarkerId('parkir_gu'),
                  position: LatLng(1.119266192849427, 104.04884385456609),
                  infoWindow: InfoWindow(
                    title: 'Parkiran Gedung Utama',
                  ),
                  onTap: () {
                    _scrollCard(0);
                  },
                ),
                // Parkiran Techno
                Marker(
                  markerId: MarkerId('parkir_techno'),
                  position: LatLng(1.1191713857641197, 104.04810983744885),
                  infoWindow: InfoWindow(
                    title: 'Parkiran Technopreneur',
                  ),
                  onTap: () {
                    _scrollCard(1);
                  },
                ),
                // Parkiran TA
                Marker(
                  markerId: MarkerId('parkir_ta'),
                  position: LatLng(1.1187655629258093, 104.04767799900829),
                  infoWindow: InfoWindow(
                    title: 'Parkiran Tower A',
                  ),
                  onTap: () {
                    _scrollCard(2);
                  },
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: false,
              zoomControlsEnabled: false,
              rotateGesturesEnabled: false,
              tiltGesturesEnabled: false,
              mapToolbarEnabled: false,
            ),
          ),
          // Memanggil Card
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 80 : 0,
                    right: index == 2 ? 0 : 80,
                  ),
                  child: Row(
                    children: [
                      _buildCard(
                        "Gedung Utama",
                        "Available",
                        "/form_rekomendasi",
                      ),
                      _buildCard(
                        "Technopreneur",
                        "Available",
                        "/form_rekomendasi",
                      ),
                      _buildCard(
                        "Tower A",
                        "Available",
                        "/form_rekomendasi",
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
