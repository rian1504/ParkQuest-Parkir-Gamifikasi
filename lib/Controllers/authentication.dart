import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkquest_parkir_gamifikasi/constants.dart';
import 'package:parkquest_parkir_gamifikasi/views/dashboard.dart';
import 'package:parkquest_parkir_gamifikasi/views/login.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

  Future register({
    required String roleId,
    required String name,
    required String username,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'role_id': roleId,
        'name': name,
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      };

      var response = await http.post(
        Uri.parse('${url}register'),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAllNamed('/login');
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
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

  Future login({
    required String roleId,
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'role_id': roleId,
        'username': username,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('${url}login'),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAllNamed('/dashboard');
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
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
