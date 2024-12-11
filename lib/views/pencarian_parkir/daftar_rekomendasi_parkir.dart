import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ParkSearchController.dart';
import 'package:parkquest_parkir_gamifikasi/views/widgets/pencarian_parkir/park_recommendation.dart';

class DaftarRekomendasiParkir extends StatelessWidget {
  DaftarRekomendasiParkir({super.key});

  // Park Area Data
  final ParkSearchController _parksearchcontroller =
      Get.put(ParkSearchController());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');

    if (token == null) {
      Future.microtask(() {
        Navigator.pushNamed(context, '/login');
      });
    }

    final parkAreaData = _parksearchcontroller.parkAreaData.value!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Park Recommendation'),
            Obx(() {
              return _parksearchcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        Text(parkAreaData.parkName),
                        Text(parkAreaData.parkImage),
                        Text(parkAreaData.parkInformation),
                      ],
                    );
            }),
            ElevatedButton(
              onPressed: () async {
                await _parksearchcontroller.parkData(
                    parkAreaId: parkAreaData.id.toString());
              },
              child: Text('Informasi'),
            ),
            Obx(() {
              return _parksearchcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _parksearchcontroller
                          .datasParkRecommendation.value.length,
                      itemBuilder: (context, index) {
                        return ParkRecommendationWidget(
                          data: _parksearchcontroller
                              .datasParkRecommendation.value[index],
                        );
                      },
                    );
            }),
          ],
        ),
      ),
    );
  }
}
