import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/InventoryController.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Avatar/UserAvatar.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class InventoryRare extends StatefulWidget {
  InventoryRare({super.key});

  @override
  State<InventoryRare> createState() => _InventoryRareState();
}

class _InventoryRareState extends State<InventoryRare> {
  // Inventory
  final InventoryController _inventorycontroller =
      Get.put(InventoryController());

  // Data Awal
  final Rxn<UserAvatarModel> dataAwal = Rxn<UserAvatarModel>();

  Future<void> _initializeData() async {
    dataAwal.value = null;
    await _inventorycontroller.inventoryRare();
    if (_inventorycontroller.datasRare.value.isNotEmpty) {
      dataAwal.value = _inventorycontroller.datasRare.value.first;
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
            Text('Inventory Rare'),
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
                                        _inventorycontroller.inventoryRare();
                                      },
                                      child: Text('Gunakan'),
                                    );
                            }),
                          ],
                        );
            }),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inventory/basic');
              },
              child: Text('Basic'),
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
                      itemCount: _inventorycontroller.datasRare.value.length,
                      itemBuilder: (context, index) {
                        final UserAvatarModel data =
                            _inventorycontroller.datasRare.value[index];
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
