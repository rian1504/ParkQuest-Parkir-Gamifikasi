import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/inventory_controller.dart';
import 'package:parkquest_parkir_gamifikasi/models/avatar/user_avatar.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  var selectedCategory = "Basic";

  // Inventory
  final InventoryController _inventorycontroller =
      Get.put(InventoryController());

  // Data Awal
  final Rxn<UserAvatarModel> dataAwal = Rxn<UserAvatarModel>();

  Future<void> _initializeData() async {
    dataAwal.value = null;

    // Panggil fungsi inventori sesuai kategori
    switch (selectedCategory) {
      case "Rare":
        await _inventorycontroller.inventoryRare();
        if (_inventorycontroller.datasRare.value.isNotEmpty) {
          dataAwal.value = _inventorycontroller.datasRare.value.first;
        }
        break;
      case "Legendary":
        await _inventorycontroller.inventoryLegendary();
        if (_inventorycontroller.datasLegendary.value.isNotEmpty) {
          dataAwal.value = _inventorycontroller.datasLegendary.value.first;
        }
        break;
      default:
        await _inventorycontroller.inventoryBasic();
        if (_inventorycontroller.datasBasic.value.isNotEmpty) {
          dataAwal.value = _inventorycontroller.datasBasic.value.first;
        }
        break;
    }

    // Perbarui tampilan setelah data berhasil dimuat
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
        title: Text(
          'Inventory',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            CupertinoIcons.chevron_left,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            _buildAvatarSection(),
            // Category
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryButton(
                    'Basic',
                    "Basic",
                    Color(0xFFD9D9D9),
                    Color(0xFF545454),
                  ),
                  _buildCategoryButton(
                    'Rare',
                    "Rare",
                    Color(0xFF5EB8FF),
                    Color(0xFF003966),
                  ),
                  _buildCategoryButton(
                    'Legendary',
                    "Legendary",
                    Color(0xFFFF2323),
                    Color(0xFF5D0000),
                  ),
                ],
              ),
            ),
            // My Avatar
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 12,
                  left: 16,
                  right: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 28),
                      child: Text(
                        'My Avatar',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: _buildItemGrid(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Avatar
  Widget _buildAvatarSection() {
    return Obx(() {
      return _inventorycontroller.isLoading.value
          ? CircularProgressIndicator()
          : dataAwal.value == null
              ? Text('Data Tidak Tersedia')
              : Column(
                  children: [
                    Text(
                      "Avatar",
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.network(
                        storageUrl + dataAwal.value!.avatarImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      dataAwal.value!.avatarName,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 160,
                      child: Obx(() {
                        return dataAwal.value!.isEquipped == 1
                            ? TextButton(
                                onPressed: () {
                                  null;
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF666666),
                                ),
                                child: Text(
                                  'Digunakan',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : TextButton(
                                onPressed: () async {
                                  await _inventorycontroller.updateAvatar(
                                      avatarId:
                                          dataAwal.value!.avatarId.toString(),
                                      onSuccess: () {
                                        _showSuccessDialog();
                                        _initializeData();
                                      });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFFFECE2E),
                                ),
                                child: Text(
                                  'Gunakan',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                      }),
                    ),
                  ],
                );
    });
  }

  // Category Button
  Widget _buildCategoryButton(
    String text,
    String role,
    Color backgroundColor,
    Color textColor,
  ) {
    return SizedBox(
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedCategory = role;
            _initializeData();
          });
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24),
          backgroundColor:
              selectedCategory == role ? backgroundColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            side: selectedCategory == role
                ? BorderSide.none
                : BorderSide(color: Colors.black),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: selectedCategory == role ? textColor : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildItemGrid() {
    return Obx(() {
      List<UserAvatarModel> currentData;

      switch (selectedCategory) {
        case "Rare":
          currentData = _inventorycontroller.datasRare.value;
          break;
        case "Legendary":
          currentData = _inventorycontroller.datasLegendary.value;
          break;
        default:
          currentData = _inventorycontroller.datasBasic.value;
      }

      return _inventorycontroller.isLoading.value
          ? CircularProgressIndicator()
          : GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1.2,
              ),
              itemCount: currentData.length,
              itemBuilder: (context, index) {
                final UserAvatarModel data = currentData[index];

                return GestureDetector(
                  onTap: () {
                    dataAwal.value = data;
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Card
                      Card(
                        elevation: 2,
                        color: selectedCategory == "Basic"
                            ? const Color(0xFFD9D9D9)
                            : selectedCategory == "Rare"
                                ? const Color(0xFF176CC7)
                                : const Color(0xFFF71010),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 16,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Avatar
                      Positioned(
                        bottom: 40,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              storageUrl + data.avatarImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
    });
  }

  // Success Dialog
  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/img/success_checked.png',
                        width: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Avatar Berhasil Digunakan!',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF24E1E),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
