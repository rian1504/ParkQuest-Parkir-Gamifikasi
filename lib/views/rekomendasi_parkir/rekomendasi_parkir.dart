import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ParkRecommendationController.dart';
import 'package:parkquest_parkir_gamifikasi/views/widgets/rekomendasi_parkir/park_area.dart';

class RekomendasiParkir extends StatelessWidget {
  RekomendasiParkir({super.key});

  // Park Area
  final ParkRecommendationController _parkrecommendationcontroller =
      Get.put(ParkRecommendationController());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');

    if (token == null) {
      Future.microtask(() {
        Navigator.pushNamed(context, '/login');
      });
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Park Area'),
            Obx(() {
              return _parkrecommendationcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          _parkrecommendationcontroller.datas.value.length,
                      itemBuilder: (context, index) {
                        return ParkArea(
                          data:
                              _parkrecommendationcontroller.datas.value[index],
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
