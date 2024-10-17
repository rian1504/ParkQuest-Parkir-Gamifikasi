import 'package:flutter/material.dart';
import 'package:parkquest_parkir_gamifikasi/pages/halaman_awal.dart';
import 'package:parkquest_parkir_gamifikasi/pages/daftar.dart';
import 'package:parkquest_parkir_gamifikasi/pages/login.dart';
import 'package:parkquest_parkir_gamifikasi/pages/dashboard.dart';
import 'package:parkquest_parkir_gamifikasi/pages/survey.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
