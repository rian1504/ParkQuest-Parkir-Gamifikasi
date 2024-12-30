import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parkquest_parkir_gamifikasi/pages/profile/profile.dart';
import 'package:parkquest_parkir_gamifikasi/pages/profile/edit_password.dart';
import 'package:parkquest_parkir_gamifikasi/pages/profile/edit_profile.dart';
import 'package:parkquest_parkir_gamifikasi/pages/profile/inventory.dart';
import 'package:parkquest_parkir_gamifikasi/pages/pencarian_parkir/detail_parkir.dart';
import 'package:parkquest_parkir_gamifikasi/pages/pencarian_parkir/pencarian_parkir.dart';
import 'package:parkquest_parkir_gamifikasi/pages/pencarian_parkir/detail_rekomendasi.dart';
import 'package:parkquest_parkir_gamifikasi/pages/rekomendasi_parkir/rekomendasi_parkir.dart';
import 'package:parkquest_parkir_gamifikasi/pages/rekomendasi_parkir/form_rekomendasi.dart';
import 'package:parkquest_parkir_gamifikasi/pages/survey/survey.dart';
import 'package:parkquest_parkir_gamifikasi/pages/survey/form_survey.dart';
import 'package:parkquest_parkir_gamifikasi/pages/shop/shop.dart';
import 'package:parkquest_parkir_gamifikasi/pages/shop/detail_shop.dart';
import 'package:parkquest_parkir_gamifikasi/pages/authentication/register.dart';
import 'package:parkquest_parkir_gamifikasi/pages/authentication/login.dart';
import 'package:parkquest_parkir_gamifikasi/pages/kode_referral.dart';
import 'package:parkquest_parkir_gamifikasi/pages/leaderboard.dart';
import 'package:parkquest_parkir_gamifikasi/pages/misi.dart';
import 'package:parkquest_parkir_gamifikasi/pages/landing_page.dart';
import 'package:parkquest_parkir_gamifikasi/pages/dashboard.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await GetStorage.init();

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
          surface: Colors.white,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Color(0xFFFEC827),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: token == null ? LandingPage() : Dashboard(),
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/dashboard': (context) => Dashboard(),
        '/rekomendasi_parkir': (context) => RekomendasiParkir(),
        '/form_rekomendasi': (context) => FormRekomendasi(),
        '/pencarian_parkir': (context) => PencarianParkir(),
        '/detail_parkir': (context) => DetailParkir(),
        '/detail_rekomendasi': (context) => DetailRekomendasi(),
        '/survey': (context) => Survey(),
        '/form_survey': (context) => FormSurvey(),
        '/shop': (context) => Shop(),
        '/shop_detail': (context) => DetailAvatar(),
        '/kode_referral': (context) => KodeReferral(),
        '/leaderboard': (context) => Leaderboard(),
        '/misi': (context) => Misi(),
        '/profile': (context) => Profile(),
        '/ubah_profile': (context) => EditProfile(),
        '/ubah_password': (context) => ChangePassword(),
        '/inventory': (context) => Inventory(),
      },
    );
  }
}
