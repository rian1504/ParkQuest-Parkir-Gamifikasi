import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/ShopController.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Avatar/Avatar.dart';

class ShopRare extends StatelessWidget {
  ShopRare({super.key});

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
            Text('Shop Rare'),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/shop/basic');
              },
              child: Text('Basic'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/shop/legendary');
              },
              child: Text('Legendary'),
            ),
            Obx(() {
              return _shopcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _shopcontroller.datasRare.value.length,
                      itemBuilder: (context, index) {
                        final AvatarModel data =
                            _shopcontroller.datasRare.value[index];

                        return Column(
                          children: [
                            Text(data.rarityName),
                            Text(data.avatarName),
                            Text(data.avatarImage),
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
