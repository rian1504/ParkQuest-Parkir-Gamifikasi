import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ParkSearchController.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Models/ParkSearch/ParkData.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class DetailPencarianParkir extends StatelessWidget {
  DetailPencarianParkir({super.key});

  // Park Data
  final ParkSearchController _parksearchcontroller =
      Get.put(ParkSearchController());

  @override
  Widget build(BuildContext context) {
    // final box = GetStorage();
    // final token = box.read('token');

    // if (token == null) {
    //   Future.microtask(() {
    //     Navigator.pushNamed(context, '/login');
    //   });
    // }

    final parkAreaData = _parksearchcontroller.parkAreaData.value!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Park Data'),
            Obx(() {
              return _parksearchcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        Image.network(
                          storageUrl + parkAreaData.parkImage,
                          width: 100,
                          height: 100,
                        ),
                        Text(parkAreaData.parkName),
                        Text(parkAreaData.parkInformation),
                      ],
                    );
            }),
            ElevatedButton(
              onPressed: () async {
                await _parksearchcontroller.parkRecommendation(
                  parkAreaId: parkAreaData.id.toString(),
                );
              },
              child: Text('Rekomendasi'),
            ),
            Obx(() {
              return _parksearchcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          _parksearchcontroller.datasParkData.value.length,
                      itemBuilder: (context, index) {
                        final ParkDataModel data =
                            _parksearchcontroller.datasParkData.value[index];

                        return Column(
                          children: [
                            Text(data.startHour.toString()),
                            Text(data.endHour.toString()),
                            Text(data.available.toString()),
                          ],
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
