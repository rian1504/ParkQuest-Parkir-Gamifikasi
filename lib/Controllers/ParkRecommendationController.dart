import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';
import 'package:parkquest_parkir_gamifikasi/Models/ParkRecommendation/ParkArea.dart';

class ParkRecommendationController extends GetxController {
  Rx<List> datas = Rx<List>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  var selectedImagePath = ''.obs;
  var selectedImageBytes = Rxn<Uint8List>();
  final ImagePicker _picker = ImagePicker();

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
        Uri.parse('${apiUrl}parkArea'),
        headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        },
      );

      final content = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;

        for (var item in content['data']) {
          datas.value.add(ParkAreaModel.fromJson(item));
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

  Future pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (kIsWeb) {
          // Jika platform adalah Web
          selectedImagePath.value = pickedFile.path;
          selectedImageBytes.value = await pickedFile.readAsBytes();
        } else {
          // Jika platform adalah selain Web
          selectedImagePath.value = pickedFile.path;
        }
      } else {
        Get.snackbar("Error", "No image selected");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future storeRekomendasi({
    required String parkAreaId,
    required String capacity,
    required String image,
    required String description,
  }) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${apiUrl}parkRecommendation/$parkAreaId'),
      );

      // Field form
      request.fields['capacity'] = capacity;
      request.fields['description'] = description;

      // Tambahkan file (Web dan non-Web)
      if (selectedImagePath.value.isNotEmpty) {
        if (kIsWeb) {
          // Jika platform adalah Web
          request.files.add(http.MultipartFile.fromBytes(
            'image', // Nama field di backend
            selectedImageBytes.value!,
            filename: selectedImagePath.value,
          ));
        } else {
          // Jika platform adalah selain Web
          request.files.add(await http.MultipartFile.fromPath(
            'image',
            selectedImagePath.value,
          ));
        }
      }

      request.headers.addAll({
        ...headers,
        'Authorization': 'Bearer $token',
      });

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final content = json.decode(response.body);

      if (response.statusCode == 201) {
        isLoading.value = false;

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
