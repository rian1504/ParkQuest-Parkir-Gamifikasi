import 'package:flutter/material.dart';
import 'package:parkquest_parkir_gamifikasi/Models/ParkSearch/ParkArea.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ParkSearchController.dart';
import 'package:get/get.dart';

class ParkArea extends StatelessWidget {
  ParkArea({
    super.key,
    required this.data,
  });

  final ParkAreaModel data;
  final _formKey = GlobalKey<FormState>();

  final Parksearchcontroller _parksearchcontroller =
      Get.put(Parksearchcontroller());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _parksearchcontroller.parkData(
                          parkAreaId: data.id.toString());
                    },
                    child: Obx(() {
                      return _parksearchcontroller.isLoading.value
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
        ),
      ),
    );
  }
}
