import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ParkSearchController.dart';
import 'package:parkquest_parkir_gamifikasi/Models/ParkSearch/ParkRecommendation.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class DaftarRekomendasiParkir extends StatelessWidget {
  DaftarRekomendasiParkir({super.key});

  // Park Area Data
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
                  parkAreaId: parkAreaData.id.toString(),
                );
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
                        final ParkRecommendationModel data =
                            _parksearchcontroller
                                .datasParkRecommendation.value[index];

                        return Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await _parksearchcontroller
                                        .parkRecommendationDetail(
                                      parkRecommendationId: data.id.toString(),
                                    );
                                  },
                                  child: Obx(() {
                                    return _parksearchcontroller.isLoading.value
                                        ? CircularProgressIndicator()
                                        : Column(
                                            children: [
                                              data.user.avatar == null
                                                  ? Image(
                                                      image: AssetImage(
                                                          'assets/img/user.png'))
                                                  : Image.network(
                                                      storageUrl +
                                                          data.user.avatar,
                                                      width: 100,
                                                      height: 100,
                                                    ),
                                              Text(data.user.name),
                                              Text(data.description),
                                            ],
                                          );
                                  }),
                                ),
                              ],
                            ),
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
