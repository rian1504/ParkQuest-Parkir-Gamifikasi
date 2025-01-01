import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/park_search_controller.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class DetailRekomendasi extends StatefulWidget {
  const DetailRekomendasi({super.key});

  @override
  State<DetailRekomendasi> createState() => _DetailRekomendasi();
}

class _DetailRekomendasi extends State<DetailRekomendasi> {
  // Data Recommendation
  final ParkSearchController _parksearchcontroller =
      Get.put(ParkSearchController());

  // Form Label
  Widget _buildFormLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Confirmation Dialog
  Future<void> _showConfirmationDialog({required int id}) async {
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
                        'assets/img/confirmation.png',
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
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
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
          actions: [
            Center(
              child: SizedBox(
                width: 130,
                height: 40,
                child: TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _parksearchcontroller.parkRecommendationAccepted(
                      parkRecommendationId: id,
                      onSuccess: () => _showSuccessDialog(),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFFEC827),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'YA',
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
                        'assets/img/success_gift.png',
                        width: 200,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Selamat! Kamu berhasil mendapatkan 20 exp',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
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

  @override
  Widget build(BuildContext context) {
    final parkRecommendationData =
        _parksearchcontroller.parkRecommendationData.value!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            CupertinoIcons.chevron_left,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: SingleChildScrollView(
            child: Obx(() {
              if (_parksearchcontroller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  // Profil
                  Row(
                    children: [
                      Column(
                        children: [
                          // Foto Profil
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: parkRecommendationData.user.avatar ==
                                        null
                                    ? Icon(Icons.person)
                                    : Image.network(
                                        storageUrl +
                                            parkRecommendationData.user.avatar,
                                        fit: BoxFit.cover,
                                      )),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama
                          Row(
                            children: [
                              Text(
                                parkRecommendationData.user.name,
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          // Waktu
                          Row(
                            children: [
                              Text(
                                '${parkRecommendationData.createdAt.hour.toString().padLeft(2, '0')}:${parkRecommendationData.createdAt.minute.toString().padLeft(2, '0')} WIB',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  // Field Kapasitas
                  _buildFormLabel("Kapasitas"),
                  SizedBox(height: 4),
                  SizedBox(
                    child: TextFormField(
                      readOnly: true,
                      initialValue: parkRecommendationData.capacity.toString(),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Field Gambar
                  _buildFormLabel('Gambar'),
                  SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    height: 190,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      storageUrl + parkRecommendationData.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Field Catatan
                  _buildFormLabel('Catatan'),
                  SizedBox(height: 4),
                  SizedBox(
                    child: TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: null,
                      initialValue: parkRecommendationData.description,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  // Text 'Apakah Membantu?'
                  Text(
                    'Apakah Membantu?',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Button Terima
                  SizedBox(
                    width: 148,
                    child: TextButton(
                      onPressed: () {
                        _showConfirmationDialog(id: parkRecommendationData.id);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFFFEC827),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        'Terima',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
