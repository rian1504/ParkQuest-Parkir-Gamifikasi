import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ReferralCodeController.dart';

class KodeReferralBagikan extends StatelessWidget {
  KodeReferralBagikan({super.key});

  // Referral
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
            Text('Kode Referral Bagikan'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/referralMasukkan');
              },
              child: Text('Referral Masukkan'),
            ),
            Obx(() {
              return _referralcodecontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : Text(_referralcodecontroller.referralCode.value);
            }),
          ],
        ),
      ),
    );
  }
}
