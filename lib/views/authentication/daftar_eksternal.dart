import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/authentication_controller.dart';

class DaftarEksternal extends StatefulWidget {
  const DaftarEksternal({super.key});

  @override
  State<DaftarEksternal> createState() => _DaftarEksternalState();
}

class _DaftarEksternalState extends State<DaftarEksternal> {
  final _formKey = GlobalKey<FormState>();
  final _roleId = TextEditingController(text: '2');
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _identityNumber = TextEditingController();
  final _company = TextEditingController();
  final _position = TextEditingController();
  final _password = TextEditingController();
  final _authenticationController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/daftarInternal');
              },
              child: Text('Daftar Internal'),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _name,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Name',
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
                      hintText: 'Perusahaan',
                    ),
                  ),
                  TextFormField(
                    controller: _position,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Posisi',
                    ),
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _authenticationController.registerEksternal(
                        roleId: _roleId.text,
                        name: _name.text,
                        username: _username.text,
                        email: _email.text,
                        identityNumber: _identityNumber.text,
                        company: _company.text,
                        position: _position.text,
                        password: _password.text,
                      );
                    },
                    child: Obx(() {
                      return _authenticationController.isLoading.value
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
