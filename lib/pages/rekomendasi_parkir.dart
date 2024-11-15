import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RekomendasiParkir extends StatefulWidget {
  const RekomendasiParkir({super.key});

  @override
  State<RekomendasiParkir> createState() => _RekomendasiParkirState();
}

class _RekomendasiParkirState extends State<RekomendasiParkir> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  // Posisi Map
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(1.1187720779636503, 104.04845573789976),
    zoom: 18,
  );

  // Lokasi Parkir
  final List<Marker> _markers = [
    // Parkiran GU
    Marker(
      markerId: MarkerId('parkir_gu'),
      position: LatLng(1.119266192849427, 104.04884385456609),
      infoWindow: InfoWindow(
        title: 'Parkiran Gedung Utama',
        onTap: () {},
      ),
    ),
    // Parkiran Techno
    Marker(
      markerId: MarkerId('parkir_techno'),
      position: LatLng(1.1191713857641197, 104.04810983744885),
      infoWindow: InfoWindow(
        title: 'Parkiran Technopreneur',
      ),
      onTap: () {},
    ),
    // Parkiran Mobil
    Marker(
      markerId: MarkerId('parkir_mobil'),
      position: LatLng(1.1187655629258093, 104.04767799900829),
      infoWindow: InfoWindow(
        title: 'Parkiran Mobil',
        onTap: () {},
      ),
    ),
  ];

  // Card
  Widget _buildCard(String title, String status) {
    return Container(
      width: 203,
      height: 63,
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
        children: [
          Padding(padding: EdgeInsets.only(left: 16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 8)),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                status,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SizedBox(width: 14),
          VerticalDivider(
            color: Colors.black,
            thickness: 1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(CupertinoIcons.chevron_right),
                iconSize: 32,
                onPressed: () {
                  Navigator.pushNamed(context, '/form_rekomendasi');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 78,
        backgroundColor: Color(0xFFFFD858),
        title: Text(
          'Lokasi',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            CupertinoIcons.chevron_left,
            size: 32,
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
              markers: Set<Marker>.of(_markers),
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: Row(
                children: [
                  _buildCard("Gedung Utama", "Available"),
                  _buildCard("Techopreneur", "Available"),
                  _buildCard("Parkiran Mobil", "Available"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
