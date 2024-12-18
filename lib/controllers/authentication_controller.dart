import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
// import 'package:parkquest_parkir_gamifikasi/Controllers/ProfileController.dart';
import 'package:parkquest_parkir_gamifikasi/Models/User.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();
  Rxn<UserModel> user = Rxn<UserModel>();

  // User
  // final ProfileController _profilecontroller = Get.put(ProfileController());

  Future registerEksternal({
    required String roleId,
    required String name,
    required String username,
    required String email,
    required String password,
    required String identityNumber,
    required String company,
    required String position,
    required Function onSuccess,
  }) async {
    try {
      isLoading.value = true;

      var data = {
        'role_id': roleId,
        'name': name,
        'username': username,
        'email': email,
        'identity_number': identityNumber,
        'company': company,
        'position': position,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('${apiUrl}register'),
        headers: headers,
        body: data,
      );

      final content = json.decode(response.body);

      if (response.statusCode == 201) {
        isLoading.value = false;

        // token.value = content['token'];
        // box.write('token', token.value);

        // Get.offAllNamed('/login');
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

  Future registerInternal({
    required String roleId,
    required String name,
    required String username,
    required String email,
    required String password,
    required String identityNumber,
    required Function onSuccess,
  }) async {
    try {
      isLoading.value = true;

      var data = {
        'role_id': roleId,
        'name': name,
        'username': username,
        'email': email,
        'identity_number': identityNumber,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('${apiUrl}register'),
        headers: headers,
        body: data,
      );

      final content = json.decode(response.body);

      if (response.statusCode == 201) {
        isLoading.value = false;

        // token.value = content['token'];
        // box.write('token', token.value);

        // Get.offAllNamed('/login');
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

  Future login({
    required String roleId,
    required String username,
    required String password,
    required Function onSuccess,
  }) async {
    try {
      isLoading.value = true;

      var data = {
        'role_id': roleId,
        'username': username,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('${apiUrl}login'),
        headers: headers,
        body: data,
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;

        final data = content['data'];
        user.value = UserModel.fromJson(data);

        // user.value = await _profilecontroller.profile();

        final token = content['token'];
        box.write('token', token);

        onSuccess();

        debugPrint(content.toString());
        Get.offAllNamed('/dashboard');
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

  Future logout() async {
    try {
      isLoading.value = true;

      final token = box.read('token');

      var response = await http.post(
        Uri.parse('${apiUrl}logout'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;

        box.remove('token');
        Get.offAllNamed('/login');

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
