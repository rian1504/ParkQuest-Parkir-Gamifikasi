import 'package:flutter/material.dart';
import 'package:parkquest_parkir_gamifikasi/Models/ParkSearch/ParkRecommendation.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ParkSearchController.dart';
import 'package:get/get.dart';

class ParkRecommendationWidget extends StatelessWidget {
  ParkRecommendationWidget({
    super.key,
    required this.data,
  });

  final ParkRecommendationModel data;

  final ParkSearchController _parksearchcontroller =
      Get.put(ParkSearchController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _parksearchcontroller.parkRecommendationDetail(
                        parkRecommendationId: data.id.toString());
                  },
                  child: Obx(() {
                    return _parksearchcontroller.isLoading.value
                        ? CircularProgressIndicator()
                        : Column(
                            children: [
                              Text(data.user.name),
                              Text(data.description),
                            ],
                          );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
