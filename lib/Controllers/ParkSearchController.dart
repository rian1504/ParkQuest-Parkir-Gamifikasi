import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkquest_parkir_gamifikasi/Models/ParkSearch/ParkArea.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class Parksearchcontroller extends GetxController {
  Rx<List> datas = Rx<List>([]);
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

      if (response.statusCode == 200) {
        isLoading.value = false;

        final content = json.decode(response.body);

        for (var item in content['data']) {
          datas.value.add(ParkAreaModel.fromJson(item));
        }

        debugPrint(content.toString());
      } else {
        isLoading.value = false;

        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      isLoading.value = false;

      debugPrint(e.toString());
    }
  }
}
