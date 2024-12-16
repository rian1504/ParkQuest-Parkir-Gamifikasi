import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parkquest_parkir_gamifikasi/views/authentication/daftar_eksternal.dart';
import 'package:parkquest_parkir_gamifikasi/views/authentication/daftar_internal.dart';
import 'package:parkquest_parkir_gamifikasi/views/dashboard.dart';
import 'package:parkquest_parkir_gamifikasi/views/halaman_awal.dart';
import 'package:parkquest_parkir_gamifikasi/views/authentication/login.dart';
import 'package:parkquest_parkir_gamifikasi/views/inventory/basic.dart';
import 'package:parkquest_parkir_gamifikasi/views/inventory/legendary.dart';
import 'package:parkquest_parkir_gamifikasi/views/inventory/rare.dart';
import 'package:parkquest_parkir_gamifikasi/views/kode_referral/bagikan.dart';
import 'package:parkquest_parkir_gamifikasi/views/kode_referral/masukkan.dart';
import 'package:parkquest_parkir_gamifikasi/views/leaderboard.dart';
import 'package:parkquest_parkir_gamifikasi/views/misi/detail_misi_daily.dart';
import 'package:parkquest_parkir_gamifikasi/views/misi/misi.dart';
import 'package:parkquest_parkir_gamifikasi/views/pencarian_parkir/daftar_rekomendasi_parkir.dart';
import 'package:parkquest_parkir_gamifikasi/views/pencarian_parkir/detail_daftar_rekomendasi_parkir.dart';
import 'package:parkquest_parkir_gamifikasi/views/pencarian_parkir/detail_pencarian_parkir.dart';
import 'package:parkquest_parkir_gamifikasi/views/pencarian_parkir/pencarian_parkir.dart';
import 'package:parkquest_parkir_gamifikasi/views/profile/setting.dart';
import 'package:parkquest_parkir_gamifikasi/views/profile/ubah_password.dart';
import 'package:parkquest_parkir_gamifikasi/views/profile/ubah_profile.dart';
import 'package:parkquest_parkir_gamifikasi/views/rekomendasi_parkir/form_rekomendasi_parkir.dart';
import 'package:parkquest_parkir_gamifikasi/views/rekomendasi_parkir/rekomendasi_parkir.dart';
import 'package:parkquest_parkir_gamifikasi/views/shop/basic.dart';
import 'package:parkquest_parkir_gamifikasi/views/shop/detail_shop.dart';
import 'package:parkquest_parkir_gamifikasi/views/shop/legendary.dart';
import 'package:parkquest_parkir_gamifikasi/views/shop/rare.dart';
import 'package:parkquest_parkir_gamifikasi/views/survey/detail_survey.dart';
import 'package:parkquest_parkir_gamifikasi/views/survey/survey.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');

    return GetMaterialApp(
      title: 'ParkQuest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFFEC827),
          primary: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: token == null ? HalamanAwal() : Dashboard(),
      routes: {
        '/login': (context) => Login(),
        '/daftarEksternal': (context) => DaftarEksternal(),
        '/daftarInternal': (context) => DaftarInternal(),
        '/dashboard': (context) => Dashboard(),
        '/pencarianParkir': (context) => PencarianParkir(),
        '/detailPencarianParkir': (context) => DetailPencarianParkir(),
        '/daftarRekomendasiParkir': (context) => DaftarRekomendasiParkir(),
        '/detailDaftarRekomendasiParkir': (context) =>
            DetailDaftarRekomendasiParkir(),
        '/rekomendasiParkir': (context) => RekomendasiParkir(),
        '/formRekomendasiParkir': (context) => FormRekomendasiParkir(),
        '/survey': (context) => Survey(),
        '/detailSurvey': (context) => DetailSurvey(),
        '/misi': (context) => Misi(),
        '/detailMisiDaily': (context) => DetailMisiDaily(),
        '/leaderboard': (context) => Leaderboard(),
        '/shop/basic': (context) => ShopBasic(),
        '/shop/rare': (context) => ShopRare(),
        '/shop/legendary': (context) => ShopLegendary(),
        '/shopDetail': (context) => DetailShop(),
        '/referralBagikan': (context) => KodeReferralBagikan(),
        '/referralMasukkan': (context) => KodeReferralMasukkan(),
        '/inventory/basic': (context) => InventoryBasic(),
        '/inventory/rare': (context) => InventoryRare(),
        '/inventory/legendary': (context) => InventoryLegendary(),
        '/setting': (context) => Setting(),
        '/ubahProfil': (context) => UbahProfile(),
        '/ubahPassword': (context) => UbahPassword(),
      },
    );
  }
}
