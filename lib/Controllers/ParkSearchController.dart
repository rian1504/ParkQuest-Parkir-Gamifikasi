import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkquest_parkir_gamifikasi/Controllers/ProfileController.dart';
import 'package:parkquest_parkir_gamifikasi/Models/ParkSearch/ParkArea.dart';
import 'package:parkquest_parkir_gamifikasi/Models/ParkSearch/ParkData.dart';
import 'package:parkquest_parkir_gamifikasi/Models/ParkSearch/ParkRecommendation.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class ParkSearchController extends GetxController {
  Rx<List> datasParkArea = Rx<List>([]);
  Rx<List> datasParkData = Rx<List>([]);
  Rx<List> datasParkRecommendation = Rx<List>([]);
  final isLoading = false.obs;
  final box = GetStorage();
  Rxn<ParkAreaModel> parkAreaData = Rxn<ParkAreaModel>();
  Rxn<ParkRecommendationModel> parkRecommendationData =
      Rxn<ParkRecommendationModel>();

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
        Uri.parse('${apiUrl}parkAreaSearch'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        datasParkArea.value.clear();
        isLoading.value = false;

        for (var item in content['data']) {
          datasParkArea.value.add(ParkAreaModel.fromJson(item));
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

  Future parkData({required String parkAreaId}) async {
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
        datasParkData.value.clear();
        isLoading.value = false;

        final dataArea = content['dataParkArea'];
        parkAreaData.value = ParkAreaModel.fromJson(dataArea);

        Get.offAllNamed('/detailPencarianParkir');

        for (var item in content['data']) {
          datasParkData.value.add(ParkDataModel.fromJson(item));
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

  Future parkRecommendation({required String parkAreaId}) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}parkRecommendation/$parkAreaId'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        datasParkRecommendation.value.clear();
        isLoading.value = false;

        Get.offAllNamed('/daftarRekomendasiParkir');

        for (var item in content['data']) {
          datasParkRecommendation.value
              .add(ParkRecommendationModel.fromJson(item));
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

  Future parkRecommendationDetail(
      {required String parkRecommendationId}) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}parkRecommendationDetail/$parkRecommendationId'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        parkRecommendationData.value = null;
        isLoading.value = false;

        final dataRecommendation = content['data'];
        parkRecommendationData.value =
            ParkRecommendationModel.fromJson(dataRecommendation);

        Get.offAllNamed('/detailDaftarRekomendasiParkir');

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

  Future parkRecommendationAccepted(
      {required String parkRecommendationId}) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.post(
        Uri.parse('${apiUrl}parkRecommendationAccepted/$parkRecommendationId'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;

        await _profilecontroller.profile();

        Get.offAllNamed('/dashboard');

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
}
