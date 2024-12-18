import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkquest_parkir_gamifikasi/models/leaderboard/leaderboard.dart';
import 'package:parkquest_parkir_gamifikasi/models/leaderboard/user_leaderboard.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class LeaderboardController extends GetxController {
  Rx<List<LeaderboardModel>> datasTopThree = Rx<List<LeaderboardModel>>([]);
  Rx<List<LeaderboardModel>> datasLeaderboard = Rx<List<LeaderboardModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();
  Rxn<UserLeaderboardModel> dataUserLeaderboard = Rxn<UserLeaderboardModel>();

  @override
  void onInit() {
    super.onInit();
    topThree();
    leaderboard();
    userLeaderboard();
  }

  Future topThree() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}topThree'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        datasTopThree.value.clear();
        isLoading.value = false;

        for (var item in content['data']) {
          datasTopThree.value.add(LeaderboardModel.fromJson(item));
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

  Future leaderboard() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}leaderboard'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        datasLeaderboard.value.clear();
        isLoading.value = false;

        for (var item in content['data']) {
          datasLeaderboard.value.add(LeaderboardModel.fromJson(item));
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

  Future userLeaderboard() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}userLeaderboard'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        dataUserLeaderboard.value = null;
        isLoading.value = false;

        final data = content['data'];
        dataUserLeaderboard.value = UserLeaderboardModel.fromJson(data);

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
