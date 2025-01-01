import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/park_search_controller.dart';
import 'package:get/get.dart';

class PencarianParkir extends StatefulWidget {
  const PencarianParkir({super.key});

  @override
  State<PencarianParkir> createState() => _PencarianParkir();
}

class _PencarianParkir extends State<PencarianParkir> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  final ScrollController _scrollController = ScrollController();

  // Camera Position
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(1.1190118543033376, 104.04844122441285),
    zoom: 18,
  );

  // Park Area
  final ParkSearchController _parksearchcontroller =
      Get.put(ParkSearchController());

  @override
  initState() {
    super.initState();
    _parksearchcontroller.parkArea();
  }

  // Card
  Widget _buildCard(String title, String status, int id) {
    return GestureDetector(
      onTap: () async {
        await _parksearchcontroller.parkData(
          parkAreaId: id,
        );
      },
      child: Container(
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
                Icon(CupertinoIcons.chevron_right, size: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Auto Scroll Card
  void _scrollCard(int index) {
    double cardOffset = 240.0 * index;
    _scrollController.animateTo(
      cardOffset,
      duration: Duration(milliseconds: 800),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
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
      body: Obx(() {
        if (_parksearchcontroller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final parkData = _parksearchcontroller.datasParkArea.value;

        Set<Marker> markers = parkData
            .map(
              (park) => Marker(
                markerId: MarkerId(park.id.toString()),
                position: LatLng(
                  double.parse(park.parkCoordinate.split(',')[0]),
                  double.parse(park.parkCoordinate.split(',')[1]),
                ),
                infoWindow: InfoWindow(
                  title: park.parkName,
                ),
                onTap: () {
                  final index = parkData.indexOf(park);
                  _scrollCard(index);
                },
              ),
            )
            .toSet();

        return Column(
          children: [
            // Maps
            SizedBox(
              height: 550,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition,
                markers: markers,
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
            // Card
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: parkData.length,
                itemBuilder: (context, index) {
                  final park = parkData[index];

                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 80 : 0,
                      right: index == 2 ? 80 : 0,
                    ),
                    child: Row(
                      children: [
                        _buildCard(
                          park.parkName,
                          "Available",
                          park.id,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
