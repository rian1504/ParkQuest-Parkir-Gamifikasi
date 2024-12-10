import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ParkSearchController.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/views/widgets/pencarian_parkir/park_area.dart';

class PencarianParkir extends StatelessWidget {
  PencarianParkir({super.key});

  // Park Area
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

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Park Area'),
            Obx(() {
              return _parksearchcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _parksearchcontroller.datas.value.length,
                      itemBuilder: (context, index) {
                        return ParkArea(
                          data: _parksearchcontroller.datas.value[index],
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
