import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/AuthenticationController.dart';

class Setting extends StatelessWidget {
  Setting({super.key});

  // Logout
  final _formKey = GlobalKey<FormState>();
  final AuthenticationController _authenticationcontroller =
      Get.put(AuthenticationController());

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
            Text('Setting'),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ubahProfil');
              },
              child: Text('Ubah Profil'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ubahPassword');
              },
              child: Text('Ubah Password'),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _authenticationcontroller.logout();
                    },
                    child: Obx(() {
                      return _authenticationcontroller.isLoading.value
                          ? CircularProgressIndicator()
                          : Text('Logout');
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
