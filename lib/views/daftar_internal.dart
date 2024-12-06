import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/authentication.dart';

class DaftarInternal extends StatefulWidget {
  const DaftarInternal({super.key});

  @override
  State<DaftarInternal> createState() => _DaftarInternalState();
}

class _DaftarInternalState extends State<DaftarInternal> {
  final _formKey = GlobalKey<FormState>();
  final _roleId = TextEditingController(text: '1');
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _identityNumber = TextEditingController();
  final _password = TextEditingController();
  final _passwordConfirmation = TextEditingController();
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
                Navigator.pushNamed(context, '/daftarEksternal');
              },
              child: Text('Daftar Eksternal'),
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
                    controller: _password,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  TextFormField(
                    controller: _passwordConfirmation,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: 'Konfirmasi Password',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _authenticationController.registerInternal(
                        roleId: _roleId.text,
                        name: _name.text,
                        username: _username.text,
                        email: _email.text,
                        identityNumber: _identityNumber.text,
                        password: _password.text,
                        passwordConfirmation: _passwordConfirmation.text,
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
