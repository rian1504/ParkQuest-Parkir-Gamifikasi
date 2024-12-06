import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/authentication.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _formKey = GlobalKey<FormState>();
  final _roleId = TextEditingController();
  final _username = TextEditingController();
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
                Navigator.pushNamed(context, '/daftarEksternal');
              },
              child: Text('Daftar Eksternal'),
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
                    controller: _roleId,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Role',
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
                    controller: _password,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _authenticationController.login(
                        roleId: _roleId.text,
                        username: _username.text.trim(),
                        password: _password.text.trim(),
                      );
                    },
                    child: Obx(() {
                      return _authenticationController.isLoading.value
                          ? CircularProgressIndicator()
                          : Text('Submit');
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
