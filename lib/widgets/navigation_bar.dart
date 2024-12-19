import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:parkquest_parkir_gamifikasi/pages/dashboard.dart';
import 'package:parkquest_parkir_gamifikasi/pages/misi.dart';
import 'package:parkquest_parkir_gamifikasi/pages/profile.dart';
import 'package:parkquest_parkir_gamifikasi/pages/shop.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Misi()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Shop()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFFEC827),
          surface: Color(0xFFFEC827),
        ),
      ),
      child: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.game_controller),
            label: 'Misi',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_crop_circle),
            label: 'Profil',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
