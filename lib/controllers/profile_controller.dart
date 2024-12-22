import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkquest_parkir_gamifikasi/controllers/authentication_controller.dart';
import 'package:parkquest_parkir_gamifikasi/Models/User.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class ProfileController extends GetxController {
  var userData = Rx<UserModel?>(null);
  final isLoading = false.obs;
  final box = GetStorage();

  // User
  final AuthenticationController _authenticationcontroller =
      Get.put(AuthenticationController());

  @override
  void onInit() {
    super.onInit();
    profile();
  }

  Future profile() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}profile'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;

        userData.value = UserModel.fromJson(content['data']);

        _authenticationcontroller.user.value =
            userData.value; // Memperbarui user di ProfileController
        _authenticationcontroller.user.refresh();
        userData.refresh();

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

  Future ubahProfile({
    required String name,
    required String username,
    required String email,
    required String identityNumber,
    String? company,
    String? position,
    required Function onSuccess,
  }) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      var data = {
        'name': name,
        'username': username,
        'email': email,
        'identity_number': identityNumber,
        'company': company,
        'position': position,
      };

      final response = await http.post(
        Uri.parse('${apiUrl}profile'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
        body: data,
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;

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

  Future UbahPassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
    required Function onSuccess,
  }) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      var data = {
        'old_password': oldPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      };

      final response = await http.post(
        Uri.parse('${apiUrl}password'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
        body: data,
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;

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
