import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/authentication.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final _formKey = GlobalKey<FormState>();
  final _authenticationController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var token = box.read('token') ?? Null;

    if (token == Null) {
      Future.microtask(() {
        Navigator.pushNamed(context, '/login');
      });
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Dashboard'),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _authenticationController.logout(
                        token: token,
                      );
                    },
                    child: Obx(() {
                      return _authenticationController.isLoading.value
                          ? CircularProgressIndicator()
                          : Text('Logout');
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
