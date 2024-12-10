import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/AvatarController.dart';
import 'package:parkquest_parkir_gamifikasi/views/widgets/shop/legendary.dart';

class ShopLegendary extends StatelessWidget {
  ShopLegendary({super.key});

  // Avatar
  final AvatarController _avatarcontroller = Get.put(AvatarController());

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
              return _avatarcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _avatarcontroller.datasLegendary.value.length,
                      itemBuilder: (context, index) {
                        return ShopLegendaryWidget(
                          data: _avatarcontroller.datasLegendary.value[index],
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
