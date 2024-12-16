import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ProfileController.dart';

class UbahProfile extends StatelessWidget {
  UbahProfile({super.key});

  // Profile
  final ProfileController _profilecontroller = Get.put(ProfileController());

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _identityNumber = TextEditingController();
  final _company = TextEditingController();
  final _position = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final box = GetStorage();
    // final token = box.read('token');

    // if (token == null) {
    //   Future.microtask(() {
    //     Navigator.pushNamed(context, '/login');
    //   });
    // }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ubah Profile'),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    if (_profilecontroller.isLoading.value) {
                      return CircularProgressIndicator();
                    }

                    final user = _profilecontroller.userData.value!;

                    // Set nilai awal ke controller hanya sekali
                    if (_name.text.isEmpty) {
                      _name.text = user.name;
                      _username.text = user.username;
                      _email.text = user.email;
                      _identityNumber.text = user.identityNumber;
                      _company.text = user.eksternal?.agencyCompany ?? '';
                      _position.text = user.eksternal?.position ?? '';
                    }

                    return Column(
                      children: [
                        TextFormField(
                          controller: _name,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Nama',
                          ),
                        ),
                        TextFormField(
                          controller: _username,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Username',
                          ),
                        ),
                        TextFormField(
                          controller: _email,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Email',
                          ),
                        ),
                        TextFormField(
                          controller: _identityNumber,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Nomor Identitas',
                          ),
                        ),
                        TextFormField(
                          controller: _company,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Instansi',
                          ),
                        ),
                        TextFormField(
                          controller: _position,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Jabatan',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await _profilecontroller.ubahProfile(
                              name: _name.text.trim(),
                              username: _username.text.trim(),
                              email: _email.text.trim(),
                              identityNumber: _identityNumber.text.trim(),
                              company: _company.text.trim(),
                              position: _position.text.trim(),
                            );
                            _profilecontroller.profile();
                          },
                          child: Obx(() {
                            return _profilecontroller.isLoading.value
                                ? CircularProgressIndicator()
                                : Text('Simpan');
                          }),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
