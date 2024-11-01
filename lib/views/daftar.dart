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
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

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
                    controller: _nameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Name',
                    ),
                  ),
                  TextFormField(
                    controller: _usernameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Username',
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  TextFormField(
                    controller: _passwordConfirmationController,
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
                        name: _nameController.text,
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        passwordConfirmation:
                            _passwordConfirmationController.text,
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
