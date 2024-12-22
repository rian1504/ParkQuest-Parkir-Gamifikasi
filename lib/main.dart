import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/pages/change_password.dart';
import 'package:parkquest_parkir_gamifikasi/pages/detail_avatar.dart';
import 'package:parkquest_parkir_gamifikasi/pages/edit_profile.dart';
import 'package:parkquest_parkir_gamifikasi/pages/inventory.dart';
import 'package:parkquest_parkir_gamifikasi/pages/kode_referral.dart';
import 'package:parkquest_parkir_gamifikasi/pages/leaderboard.dart';
import 'package:parkquest_parkir_gamifikasi/pages/misi.dart';
import 'package:parkquest_parkir_gamifikasi/pages/pencarian_parkir.dart';
import 'package:parkquest_parkir_gamifikasi/pages/landing_page.dart';
import 'package:parkquest_parkir_gamifikasi/pages/register.dart';
import 'package:parkquest_parkir_gamifikasi/pages/login.dart';
import 'package:parkquest_parkir_gamifikasi/pages/dashboard.dart';
import 'package:parkquest_parkir_gamifikasi/pages/profile.dart';
import 'package:parkquest_parkir_gamifikasi/pages/rekomendasi_parkir.dart';
import 'package:parkquest_parkir_gamifikasi/pages/shop.dart';
import 'package:parkquest_parkir_gamifikasi/pages/survey.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ParkQuest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFFEC827),
          primary: Colors.black,
          surface: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/dashboard': (context) => Dashboard(),
        '/rekomendasi_parkir': (context) => RekomendasiParkir(),
        '/pencarian_parkir': (context) => PencarianParkir(),
        '/survey': (context) => Survey(),
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
