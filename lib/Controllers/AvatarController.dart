import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkquest_parkir_gamifikasi/Models/Avatar/Avatar.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class AvatarController extends GetxController {
  Rx<List<AvatarModel>> datasBasic = Rx<List<AvatarModel>>([]);
  Rx<List<AvatarModel>> datasRare = Rx<List<AvatarModel>>([]);
  Rx<List<AvatarModel>> datasLegendary = Rx<List<AvatarModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    shopBasic();
    shopRare();
    shopLegendary();
  }

  Future shopBasic() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}shop/basic'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;

        final content = json.decode(response.body);

        for (var item in content['data']) {
          datasBasic.value.add(AvatarModel.fromJson(item));
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

  Future shopRare() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}shop/rare'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;

        final content = json.decode(response.body);

        for (var item in content['data']) {
          datasRare.value.add(AvatarModel.fromJson(item));
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

  Future shopLegendary() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}shop/legendary'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;

        final content = json.decode(response.body);

        for (var item in content['data']) {
          datasLegendary.value.add(AvatarModel.fromJson(item));
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
