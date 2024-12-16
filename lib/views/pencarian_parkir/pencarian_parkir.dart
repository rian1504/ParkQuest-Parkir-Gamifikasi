import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/park_search_controller.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/models/park_search/park_area.dart';

class PencarianParkir extends StatelessWidget {
  PencarianParkir({super.key});

  // Park Area
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
                      itemCount:
                          _parksearchcontroller.datasParkArea.value.length,
                      itemBuilder: (context, index) {
                        final ParkAreaModel data =
                            _parksearchcontroller.datasParkArea.value[index];
                        final formKey = GlobalKey<FormState>();

                        return Column(
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await _parksearchcontroller.parkData(
                                        parkAreaId: data.id.toString(),
                                      );
                                      _parksearchcontroller.parkArea();
                                    },
                                    child: Obx(() {
                                      return _parksearchcontroller
                                              .isLoading.value
                                          ? CircularProgressIndicator()
                                          : Text(data.parkName);
                                    }),
                                  ),
                                ],
                              ),
                            ),
                            Text(data.id.toString()),
                            Text(data.parkName),
                            Text(data.parkCoordinate),
                            Text(data.parkCapacity.toString()),
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
