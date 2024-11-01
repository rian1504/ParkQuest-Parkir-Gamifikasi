import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/authentication.dart';

class Daftar extends StatefulWidget {
  const Daftar({super.key});

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  final _formKey = GlobalKey<FormState>();
  final _roleId = TextEditingController(text: '1');
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
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
                      await _authenticationController.register(
                        roleId: _roleId.text,
                        name: _name.text,
                        username: _username.text,
                        email: _email.text,
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
