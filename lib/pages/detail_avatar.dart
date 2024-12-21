import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/shop_controller.dart';

class DetailAvatar extends StatefulWidget {
  // final String imagePath;
  // final String title;

  // const DetailAvatar({super.key, required this.imagePath, required this.title});
  const DetailAvatar({super.key});

  @override
  State<DetailAvatar> createState() => _DetailAvatarState();
}

class _DetailAvatarState extends State<DetailAvatar> {
  // Avatar Data
  final ShopController _shopcontroller = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    final avatarDetailData = _shopcontroller.avatarDetailData.value!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
        title: Text(
          'Detail Shop',
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
      body: Center(
        child: Obx(() {
          return _shopcontroller.isLoading.value
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      avatarDetailData.avatarName,
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        // ignore: avoid_print
                        print(rating);
                      },
                    ),
                    //Hero Widget dari Shop
                    const SizedBox(height: 12),
                    Hero(
                      tag: avatarDetailData.id,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.network(avatarDetailData.avatarImage),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/coin.png',
                          width: 80,
                        ),
                        Text(
                          avatarDetailData.rarity.price.toString(),
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        _showConfirmationDialog(avatarId: avatarDetailData.id);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFEC827),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(CupertinoIcons.bag_fill,
                          color: Colors.white),
                      label: Text(
                        "Beli",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }

  // Confirmation Dialog
  Future<void> _showConfirmationDialog({required int avatarId}) async {
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
                        'assets/img/question_mark.png',
                        width: 200,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Apakah anda yakin?',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: [
            // Button Ya
            Center(
              child: SizedBox(
                width: 130,
                height: 40,
                child: TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _shopcontroller.buyAvatar(
                      avatarId: avatarId,
                      onSuccess: () {
                        _showSuccessDialog();
                        _shopcontroller.shopBasic();
                        _shopcontroller.shopRare();
                        _shopcontroller.shopLegendary();
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFFEC827),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Ya',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Button Tidak
            Center(
              child: SizedBox(
                width: 130,
                height: 40,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFFEC827),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Tidak',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
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
                        'Pembelian Berhasil!',
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
                        Navigator.pushNamed(context, '/dashboard');
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
