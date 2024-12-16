import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/park_recommendation_controller.dart';
import 'package:get/get.dart';
import 'dart:io';

class FormRekomendasiParkir extends StatelessWidget {
  FormRekomendasiParkir({super.key});

  final _formKey = GlobalKey<FormState>();
  final _capacity = TextEditingController();
  final _description = TextEditingController();

  final ParkRecommendationController _parkrecommendationcontroller =
      Get.put(ParkRecommendationController());

  @override
  Widget build(BuildContext context) {
    // Ambil arguments
    final parkAreaId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _capacity,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Kapasitas',
                    ),
                  ),
                  Obx(() {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _parkrecommendationcontroller.pickImage();
                          },
                          child: _parkrecommendationcontroller
                                  .selectedImagePath.value.isNotEmpty
                              ? (kIsWeb
                                  ? Image.network(
                                      _parkrecommendationcontroller
                                          .selectedImagePath.value,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(_parkrecommendationcontroller
                                          .selectedImagePath.value),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ))
                              : Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.add_a_photo),
                                ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _parkrecommendationcontroller
                                  .selectedImagePath.value.isNotEmpty
                              ? "Gambar dipilih"
                              : "Pilih gambar",
                        ),
                      ],
                    );
                  }),
                  TextFormField(
                    controller: _description,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Deskripsi',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _parkrecommendationcontroller.storeRekomendasi(
                        parkAreaId: parkAreaId.toString(),
                        capacity: _capacity.text.trim(),
                        image: _parkrecommendationcontroller
                            .selectedImagePath.value,
                        description: _description.text.trim(),
                      );
                      _capacity.clear();
                      _description.clear();
                    },
                    child: Obx(() {
                      return _parkrecommendationcontroller.isLoading.value
                          ? CircularProgressIndicator()
                          : Text('Submit');
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
