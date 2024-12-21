import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/referral_code_controller.dart';

class KodeReferral extends StatefulWidget {
  const KodeReferral({super.key});

  @override
  State<KodeReferral> createState() => _KodeReferralState();
}

class _KodeReferralState extends State<KodeReferral> {
  // Referral
  final _referralCode = TextEditingController();
  final ReferralCodeController _referralcodecontroller =
      Get.put(ReferralCodeController());

  // Container
  Widget _buildContainer(double height, Widget child) {
    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.all(50),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
        title: Text(
          'Kode Referral',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w500,
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // Tab Bar
            TabBar(
              indicatorColor: Color(0xFFFEC827),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              tabs: [
                Tab(text: 'Bagikan'),
                Tab(text: 'Masukkan'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab Bagikan
                  Column(
                    children: [
                      // Container
                      _buildContainer(
                        480,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/kode_referral_bagikan.png',
                              width: 260,
                            ),
                            SizedBox(height: 50),
                            Text(
                              'Ajak temanmu dan dapatkan Coinnya!',
                              style: GoogleFonts.inter(
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(32),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              // Kode Referral
                              Obx(() {
                                return _referralcodecontroller.isLoading.value
                                    ? CircularProgressIndicator()
                                    : Expanded(
                                        child: Text(
                                          _referralcodecontroller
                                              .referralCode.value,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                              }),
                              // Button Salin Kode
                              SizedBox(
                                height: double.infinity,
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFFFEC827),
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(10),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                  ),
                                  child: Text(
                                    'Salin Kode',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Tab Masukkan
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        // Container
                        _buildContainer(
                          350,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/img/kode_referral_masukkan.png',
                                width: 160,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(32),
                          child: Column(
                            children: [
                              // Title Text
                              Text(
                                'Masukkan kode anda disini:',
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(height: 10),
                              // Field Kode
                              SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: TextFormField(
                                  controller: _referralCode,
                                  decoration: InputDecoration(
                                    hintText: 'Kode Promosi',
                                    hintStyle: GoogleFonts.inter(
                                      fontWeight: FontWeight.w300,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                              // Submit Button
                              SizedBox(
                                width: 200,
                                child: TextButton(
                                  onPressed: () async {
                                    await _referralcodecontroller.store(
                                      referralCode: _referralCode.text.trim(),
                                      onSuccess: () {
                                        _referralCode.clear();
                                      },
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFFFEC827),
                                  ),
                                  child: Text(
                                    'Konfirmasi',
                                    style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
