import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/InventoryController.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Avatar/UserAvatar.dart';

class InventoryLegendary extends StatelessWidget {
  InventoryLegendary({super.key});

  // Inventory
  final InventoryController _inventorycontroller =
      Get.put(InventoryController());

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
            Text('Inventory Legendary'),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inventory/rare');
              },
              child: Text('Rare'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inventory/basic');
              },
              child: Text('Basic'),
            ),
            Obx(() {
              return _inventorycontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          _inventorycontroller.datasLegendary.value.length,
                      itemBuilder: (context, index) {
                        final UserAvatarModel data =
                            _inventorycontroller.datasLegendary.value[index];
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
