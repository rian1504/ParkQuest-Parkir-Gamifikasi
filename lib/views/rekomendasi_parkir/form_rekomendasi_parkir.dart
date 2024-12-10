import 'package:flutter/material.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ParkRecommendationController.dart';
import 'package:get/get.dart';

class FormRekomendasiParkir extends StatelessWidget {
  FormRekomendasiParkir({super.key});

  final _formKey = GlobalKey<FormState>();
  final _capacity = TextEditingController();
  final _image = TextEditingController();
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
                  TextFormField(
                    controller: _image,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Gambar',
                    ),
                  ),
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
                        capacity: _capacity.text,
                        image: _image.text,
                        description: _description.text,
                      );
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
