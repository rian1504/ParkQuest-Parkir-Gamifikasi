import 'package:flutter/material.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ParkSearchController.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class DetailDaftarRekomendasiParkir extends StatelessWidget {
  DetailDaftarRekomendasiParkir({super.key});

  // Data Recommendation
  final ParkSearchController _parksearchcontroller =
      Get.put(ParkSearchController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');

    if (token == null) {
      Future.microtask(() {
        Navigator.pushNamed(context, '/login');
      });
    }

    final parkRecommendationData =
        _parksearchcontroller.parkRecommendationData.value!;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _parksearchcontroller.parkRecommendationAccepted(
                          parkRecommendationId:
                              parkRecommendationData.id.toString());
                    },
                    child: Obx(() {
                      return _parksearchcontroller.isLoading.value
                          ? CircularProgressIndicator()
                          : Text('Terima');
                    }),
                  ),
                ],
              ),
            ),
            Obx(() {
              return _parksearchcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        Text(parkRecommendationData.user.name),
                        Text(parkRecommendationData.capacity.toString()),
                        Text(parkRecommendationData.image),
                        Text(parkRecommendationData.description),
                      ],
                    );
            }),
          ],
        ),
      ),
    );
  }
}
