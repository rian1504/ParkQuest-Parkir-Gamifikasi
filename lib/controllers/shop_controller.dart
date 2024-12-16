import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkquest_parkir_gamifikasi/controllers/inventory_controller.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/profile_controller.dart';
import 'package:parkquest_parkir_gamifikasi/models/avatar/avatar.dart';
import 'package:parkquest_parkir_gamifikasi/models/avatar/avatar_detail.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class ShopController extends GetxController {
  Rx<List<AvatarModel>> datasBasic = Rx<List<AvatarModel>>([]);
  Rx<List<AvatarModel>> datasRare = Rx<List<AvatarModel>>([]);
  Rx<List<AvatarModel>> datasLegendary = Rx<List<AvatarModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();
  Rxn<AvatarDetailModel> avatarDetailData = Rxn<AvatarDetailModel>();

  // User
  final ProfileController _profilecontroller = Get.put(ProfileController());

  // Inventory
  final InventoryController _inventorycontroller =
      Get.put(InventoryController());

  @override
  void onInit() {
    super.onInit();
    shopBasic();
    shopRare();
    shopLegendary();
  }

  Future shopBasic() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}shop/basic'),
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
          datasBasic.value.add(AvatarModel.fromJson(item));
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

  Future shopRare() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}shop/rare'),
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
          datasRare.value.add(AvatarModel.fromJson(item));
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

  Future shopLegendary() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}shop/legendary'),
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
          datasLegendary.value.add(AvatarModel.fromJson(item));
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

  Future shopDetail({required String avatarId}) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${apiUrl}shop/detail/$avatarId'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        avatarDetailData.value = null;
        isLoading.value = false;

        final dataAvatar = content['data'];
        avatarDetailData.value = AvatarDetailModel.fromJson(dataAvatar);

        Get.offAllNamed('/shopDetail');

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

  Future buyAvatar({required String avatarId}) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.post(
        Uri.parse('${apiUrl}shop/buyAvatar/$avatarId'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 201) {
        isLoading.value = false;

        await _profilecontroller.profile();
        await _inventorycontroller.inventoryBasic();
        await _inventorycontroller.inventoryRare();
        await _inventorycontroller.inventoryLegendary();

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
