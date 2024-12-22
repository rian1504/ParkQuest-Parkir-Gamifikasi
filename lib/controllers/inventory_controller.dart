import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkquest_parkir_gamifikasi/controllers/leaderboard_controller.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/profile_controller.dart';
import 'package:parkquest_parkir_gamifikasi/models/avatar/user_avatar.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class InventoryController extends GetxController {
  Rx<List<UserAvatarModel>> datasBasic = Rx<List<UserAvatarModel>>([]);
  Rx<List<UserAvatarModel>> datasRare = Rx<List<UserAvatarModel>>([]);
  Rx<List<UserAvatarModel>> datasLegendary = Rx<List<UserAvatarModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  // User
  final ProfileController _profilecontroller = Get.put(ProfileController());
  // User Leaderboard
  final LeaderboardController _leaderboardcontroller =
      Get.put(LeaderboardController());

  @override
  void onInit() {
    super.onInit();
    inventoryBasic();
    inventoryRare();
    inventoryLegendary();
  }

  Future inventoryBasic() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}inventory/basic'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        datasBasic.value.clear();
        isLoading.value = false;

        for (var item in content['data']) {
          datasBasic.value.add(UserAvatarModel.fromJson(item));
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

  Future inventoryRare() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}inventory/rare'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        datasRare.value.clear();
        isLoading.value = false;

        for (var item in content['data']) {
          datasRare.value.add(UserAvatarModel.fromJson(item));
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

  Future inventoryLegendary() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}inventory/legendary'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        datasLegendary.value.clear();
        isLoading.value = false;

        for (var item in content['data']) {
          datasLegendary.value.add(UserAvatarModel.fromJson(item));
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

  Future updateAvatar({
    required String avatarId,
    required Function onSuccess,
  }) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.post(
        Uri.parse('${apiUrl}inventory/updateAvatar/$avatarId'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;

        await _profilecontroller.profile();
        await _leaderboardcontroller.userLeaderboard();

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
