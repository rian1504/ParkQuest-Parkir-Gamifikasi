import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/profile_controller.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Mission.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class MissionController extends GetxController {
  Rx<List<MissionModel>> datas = Rx<List<MissionModel>>([]);
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
        Uri.parse('${apiUrl}mission'),
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
          datas.value.add(MissionModel.fromJson(item));
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

  Future dailyLogin({required Function onSuccess}) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.post(
        Uri.parse('${apiUrl}dailyLogin'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
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
