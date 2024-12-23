import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkquest_parkir_gamifikasi/constants.dart';
import 'package:parkquest_parkir_gamifikasi/models/park_recommendation/park_area.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/profile_controller.dart';

class ParkRecommendationController extends GetxController {
  Rx<List> datas = Rx<List>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  var selectedImagePath = ''.obs;
  var selectedImageBytes = Rxn<Uint8List>();

  // User
  final ProfileController _profilecontroller = Get.put(ProfileController());

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
        Uri.parse('${apiUrl}parkArea'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        datas.value.clear();
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

  Future storeRekomendasi({
    required int parkAreaId,
    required String capacity,
    required String image,
    required String description,
    required Function onSuccess,
  }) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${apiUrl}parkRecommendation/$parkAreaId'),
      );

      // Field form
      request.fields['capacity'] = capacity;
      request.fields['description'] = description;
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image,
      ));

      request.headers.addAll({
        ...headers,
        'Authorization': 'Bearer $token',
      });

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final content = json.decode(response.body);

      if (response.statusCode == 201) {
        selectedImagePath.value = '';
        isLoading.value = false;

        await _profilecontroller.profile();

        // Get.offAllNamed('/dashboard');
        debugPrint(content.toString());

        onSuccess();
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
