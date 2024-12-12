import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ShopController.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class DetailShop extends StatelessWidget {
  DetailShop({super.key});

  // Avatar Data
  final ShopController _shopcontroller = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');

    if (token == null) {
      Future.microtask(() {
        Navigator.pushNamed(context, '/login');
      });
    }

    final avatarDetailData = _shopcontroller.avatarDetailData.value!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Detail Shop'),
            Obx(() {
              return _shopcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        Image.network(
                          storageUrl + avatarDetailData.avatarImage,
                          width: 100,
                          height: 100,
                        ),
                        Text(avatarDetailData.avatarName),
                        Text(avatarDetailData.rarity.price.toString()),
                      ],
                    );
            }),
            ElevatedButton(
              onPressed: () async {
                await _shopcontroller.buyAvatar(
                    avatarId: avatarDetailData.id.toString());
              },
              child: Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }
}
