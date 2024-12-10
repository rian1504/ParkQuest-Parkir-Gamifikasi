import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/AvatarController.dart';
import 'package:parkquest_parkir_gamifikasi/views/widgets/shop/rare.dart';

class ShopRare extends StatelessWidget {
  ShopRare({super.key});

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
              return _avatarcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _avatarcontroller.datasRare.value.length,
                      itemBuilder: (context, index) {
                        return ShopRareWidget(
                          data: _avatarcontroller.datasRare.value[index],
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
