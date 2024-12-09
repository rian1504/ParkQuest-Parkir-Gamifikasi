import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

  Future registerEksternal({
    required String roleId,
    required String name,
    required String username,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String identityNumber,
    required String company,
    required String position,
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
        'password_confirmation': passwordConfirmation,
      };

      var response = await http.post(
        Uri.parse('${apiUrl}register'),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAllNamed('/login');
        debugPrint(json.decode(response.body).toString());
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

  Future registerInternal({
    required String roleId,
    required String name,
    required String username,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String identityNumber,
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
        'password_confirmation': passwordConfirmation,
      };

      var response = await http.post(
        Uri.parse('${apiUrl}register'),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAllNamed('/login');
        debugPrint(json.decode(response.body).toString());
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
        Uri.parse('${apiUrl}login'),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        final token = json.decode(response.body)['token'];
        box.write('token', token);
        Get.offAllNamed('/dashboard');
        debugPrint(json.decode(response.body).toString());
        debugPrint(token);
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

  Future logout({
    required String token,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'token': token,
      };

      var response = await http.post(
        Uri.parse('${apiUrl}logout'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        box.remove('token');
        Get.offAllNamed('/login');
        debugPrint(json.decode(response.body).toString());
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
