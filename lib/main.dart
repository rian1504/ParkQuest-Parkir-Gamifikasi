import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parkquest_parkir_gamifikasi/views/daftar_eksternal.dart';
import 'package:parkquest_parkir_gamifikasi/views/daftar_internal.dart';
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
        '/survey': (context) => Survey(),
      },
    );
  }
}
