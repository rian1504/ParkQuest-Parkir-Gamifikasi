import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/views/daftar.dart';
import 'package:parkquest_parkir_gamifikasi/views/dashboard.dart';
import 'package:parkquest_parkir_gamifikasi/views/halaman_awal.dart';
import 'package:parkquest_parkir_gamifikasi/views/login.dart';
import 'package:parkquest_parkir_gamifikasi/views/survey.dart';

void main() {
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
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HalamanAwal(),
      routes: {
        '/login': (context) => Login(),
        '/daftar': (context) => Daftar(),
        '/dashboard': (context) => Dashboard(),
        '/survey': (context) => Survey(),
      },
    );
  }
}
