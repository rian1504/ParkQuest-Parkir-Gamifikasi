import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/inventory_controller.dart';
import 'package:parkquest_parkir_gamifikasi/models/avatar/user_avatar.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class InventoryBasic extends StatefulWidget {
  InventoryBasic({super.key});

  @override
  State<InventoryBasic> createState() => _InventoryBasicState();
}

class _InventoryBasicState extends State<InventoryBasic> {
  // Inventory
  final InventoryController _inventorycontroller =
      Get.put(InventoryController());

  // Data Awal
  final Rxn<UserAvatarModel> dataAwal = Rxn<UserAvatarModel>();

  Future<void> _initializeData() async {
    dataAwal.value = null;
    await _inventorycontroller.inventoryBasic();
    if (_inventorycontroller.datasBasic.value.isNotEmpty) {
      dataAwal.value = _inventorycontroller.datasBasic.value.first;
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    // final box = GetStorage();
    // final token = box.read('token');

    // if (token == null) {
    //   Future.microtask(() {
    //     Navigator.pushNamed(context, '/login');
    //   });
    // }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Inventory Basic'),
            Obx(() {
              return _inventorycontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : dataAwal.value == null
                      ? Text('No Data Available')
                      : Column(
                          children: [
                            Image.network(
                              storageUrl + dataAwal.value!.avatarImage,
                              width: 100,
                              height: 100,
                            ),
                            Text(dataAwal.value!.avatarId.toString()),
                            Text(dataAwal.value!.avatarName),
                            Text(dataAwal.value!.avatarDescription),
                            Obx(() {
                              return dataAwal.value!.isEquipped == 1
                                  ? Text('Digunakan')
                                  : ElevatedButton(
                                      onPressed: () async {
                                        await _inventorycontroller.updateAvatar(
                                          avatarId: dataAwal.value!.avatarId
                                              .toString(),
                                        );
                                        _inventorycontroller.inventoryBasic();
                                      },
                                      child: Text('Gunakan'),
                                    );
                            }),
                          ],
                        );
            }),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inventory/rare');
              },
              child: Text('Rare'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inventory/legendary');
              },
              child: Text('Legendary'),
            ),
            Obx(() {
              return _inventorycontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _inventorycontroller.datasBasic.value.length,
                      itemBuilder: (context, index) {
                        final UserAvatarModel data =
                            _inventorycontroller.datasBasic.value[index];
                        return GestureDetector(
                          onTap: () {
                            // Perbarui nilai dataAwal ketika item diklik
                            dataAwal.value = data;
                          },
                          child: Column(
                            children: [
                              Image.network(
                                storageUrl + data.avatarImage,
                                width: 100,
                                height: 100,
                              ),
                              Text(data.avatarName),
                              Text(data.avatarDescription),
                            ],
                          ),
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
