import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ProfileController.dart';

class UbahPassword extends StatelessWidget {
  UbahPassword({super.key});

  // Profile
  final ProfileController _profilecontroller = Get.put(ProfileController());

  final _formKey = GlobalKey<FormState>();
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _newPasswordConfirmation = TextEditingController();

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
            Text('Ubah Password'),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _oldPassword,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: 'Password Lama',
                    ),
                  ),
                  TextFormField(
                    controller: _newPassword,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: 'Password Baru',
                    ),
                  ),
                  TextFormField(
                    controller: _newPasswordConfirmation,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: 'Konfirmasi Password Baru',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _profilecontroller.UbahPassword(
                        oldPassword: _oldPassword.text.trim(),
                        newPassword: _newPassword.text.trim(),
                        newPasswordConfirmation:
                            _newPasswordConfirmation.text.trim(),
                      );
                    },
                    child: Obx(() {
                      return _profilecontroller.isLoading.value
                          ? CircularProgressIndicator()
                          : Text('Simpan');
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
