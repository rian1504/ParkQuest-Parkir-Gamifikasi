import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ShopController.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Avatar/Avatar.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class ShopLegendary extends StatelessWidget {
  ShopLegendary({super.key});

  // Shop
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

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Shop Legendary'),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/shop/rare');
              },
              child: Text('Rare'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/shop/basic');
              },
              child: Text('Basic'),
            ),
            Obx(() {
              return _shopcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _shopcontroller.datasLegendary.value.length,
                      itemBuilder: (context, index) {
                        final AvatarModel data =
                            _shopcontroller.datasLegendary.value[index];

                        return Column(
                          children: [
                            Image.network(
                              storageUrl + data.avatarImage,
                              width: 100,
                              height: 100,
                            ),
                            Text(data.avatarName),
                            Text(data.avatarDescription),
                          ],
                        );
                      },
                    );
            }),
          ],
        ),
      ),
    );
  }
}
