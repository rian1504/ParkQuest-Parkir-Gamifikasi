import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkquest_parkir_gamifikasi/Controllers/profile_controller.dart';
import 'package:parkquest_parkir_gamifikasi/models/survey/survey.dart';
import 'package:parkquest_parkir_gamifikasi/models/survey/survey_detail.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class SurveyController extends GetxController {
  Rx<List> datas = Rx<List>([]);
  Rx<List> datasDetail = Rx<List>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  // User
  final ProfileController _profilecontroller = Get.put(ProfileController());

  @override
  void onInit() {
    super.onInit();
    index();
  }

  Future index() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}survey'),
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
          datas.value.add(SurveyModel.fromJson(item));
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

  Future detail({required String surveyId}) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}survey/$surveyId'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        datasDetail.value.clear();
        isLoading.value = false;

        datasDetail.value.add(SurveyDetailModel.fromJson(content['data']));

        // Get.offAllNamed('/form_survey');
        debugPrint(content.toString());

        Get.toNamed('/form_survey');
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

  Future submit({
    required int surveyId,
    required List<Map<String, dynamic>> answers,
    required Function onSuccess,
  }) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      var data = {'answers': answers};

      // Debug print untuk memeriksa data yang dikirim
      debugPrint(json.encode(data));

      final response = await http.post(
        Uri.parse('${apiUrl}survey/$surveyId'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
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
