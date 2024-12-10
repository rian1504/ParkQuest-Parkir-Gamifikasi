import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ProfileController.dart';
import 'package:parkquest_parkir_gamifikasi/views/widgets/profile/profile.dart';

class UbahProfile extends StatelessWidget {
  UbahProfile({super.key});

  // Profile
  final ProfileController _profilecontroller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');

    if (token == null) {
      Future.microtask(() {
        Navigator.pushNamed(context, '/login');
      });
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ubah Profile'),
            Obx(() {
              return _profilecontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : UbahProfileWidget(
                      data: _profilecontroller.datas.value!,
                    );
            }),
          ],
        ),
      ),
    );
  }
}
