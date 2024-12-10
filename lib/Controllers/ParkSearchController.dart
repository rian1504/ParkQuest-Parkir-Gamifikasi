import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkquest_parkir_gamifikasi/Models/ParkSearch/ParkArea.dart';
import 'package:parkquest_parkir_gamifikasi/Models/ParkSearch/ParkData.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class Parksearchcontroller extends GetxController {
  Rx<List> datas = Rx<List>([]);
  Rx<List> datas2 = Rx<List>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    parkArea();
  }

  Future parkArea() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}parkAreaSearch'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;

        for (var item in content['data']) {
          datas.value.add(ParkAreaModel.fromJson(item));
        }

        debugPrint(content.toString());
      } else {
        isLoading.value = false;

        Get.snackbar(
          'Error',
          content['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        debugPrint(content.toString());
      }
    } catch (e) {
      isLoading.value = false;

      debugPrint(e.toString());
    }
  }

  Future parkData({
    required String parkAreaId,
  }) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}parkData/$parkAreaId'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;

        Get.offAllNamed('/detailPencarianParkir');

        for (var item in content['data']) {
          datas2.value.add(ParkDataModel.fromJson(item));
        }

        debugPrint(content.toString());
        // final dataAreaParkir = content['dataParkArea'];
        // return dataAreaParkir;
      } else {
        isLoading.value = false;

        Get.snackbar(
          'Error',
          content['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        debugPrint(content.toString());
      }
    } catch (e) {
      isLoading.value = false;

      debugPrint(e.toString());
    }
  }
}
