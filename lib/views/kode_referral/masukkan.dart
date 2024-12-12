import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ReferralCodeController.dart';

class KodeReferralMasukkan extends StatelessWidget {
  KodeReferralMasukkan({super.key});

  final _formKey = GlobalKey<FormState>();
  final _referralCode = TextEditingController();
  final ReferralCodeController _referralcodecontroller =
      Get.put(ReferralCodeController());

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
            Text('Masukkan kode referral'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/referralBagikan');
              },
              child: Text('Referral Bagikan'),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _referralCode,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Kode Referral',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _referralcodecontroller.store(
                          referralCode: _referralCode.text.trim());
                    },
                    child: Obx(() {
                      return _referralcodecontroller.isLoading.value
                          ? CircularProgressIndicator()
                          : Text('Konfirmasi');
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
