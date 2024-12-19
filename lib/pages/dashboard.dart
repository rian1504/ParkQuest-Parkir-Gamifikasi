import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkquest_parkir_gamifikasi/pages/inventory.dart';
import 'package:parkquest_parkir_gamifikasi/pages/kode_referral.dart';
import 'package:parkquest_parkir_gamifikasi/pages/leaderboard.dart';
import 'package:parkquest_parkir_gamifikasi/pages/misi.dart';
import 'package:parkquest_parkir_gamifikasi/pages/pencarian_parkir.dart';
import 'package:parkquest_parkir_gamifikasi/pages/rekomendasi_parkir.dart';
import 'package:parkquest_parkir_gamifikasi/pages/shop.dart';
import 'package:parkquest_parkir_gamifikasi/pages/survey.dart';
import 'package:parkquest_parkir_gamifikasi/widgets/navigation_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 48,
                right: 24,
                left: 24,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Color(0xFFFEC827),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // App Title
                  Text(
                    'ParkQuest',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // Profile
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          child: Icon(Icons.person),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, Elys!',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '@elysaulia20',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '100 EXP',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/img/coin.png',
                              width: 32,
                            ),
                            Text(
                              '5 Coins',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Main Features
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PencarianParkir(),
                            ),
                          );
                        },
                        child: _buildMainFeatureCard(
                          CupertinoIcons.search,
                          'Cari Parkir',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RekomendasiParkir(),
                            ),
                          );
                        },
                        child: _buildMainFeatureCard(
                          CupertinoIcons.star,
                          'Rekomendasi Parkir',
                        ),
                      ),
                    ],
                  ),
                  // Features
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // Survey
                      _buildFeatures(
                        context,
                        Survey(),
                        CupertinoIcons.doc_plaintext,
                        'Survey',
                      ),
                      // Shop
                      _buildFeatures(
                        context,
                        Shop(),
                        CupertinoIcons.cart,
                        'Shop',
                      ),
                      // Misi
                      _buildFeatures(
                        context,
                        Misi(),
                        CupertinoIcons.game_controller,
                        'Misi',
                      ),
                      // Inventory
                      _buildFeatures(
                        context,
                        Inventory(),
                        CupertinoIcons.archivebox,
                        'Inventory',
                      ),
                      // Kode Referral
                      _buildFeatures(
                        context,
                        KodeReferral(),
                        CupertinoIcons.person_add,
                        'Kode Referral',
                      ),
                      // Leaderboard
                      _buildFeatures(
                        context,
                        Leaderboard(),
                        CupertinoIcons.flag,
                        'Leaderboard',
                      ),
                    ],
                  ),
                  // Leaderboard
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Leaderboard',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // 1st Place
                      _buildLeaderboardCard(
                        'assets/img/1st_place_medal.png',
                        '@jihan65',
                        'Mahasiswa',
                        'Kang Parkir',
                      ),
                      // 2nd Place
                      _buildLeaderboardCard(
                        'assets/img/2nd_place_medal.png',
                        '@jihan65',
                        'Mahasiswa',
                        'Kang Parkir',
                      ),
                      // 3rd Place
                      _buildLeaderboardCard(
                        'assets/img/3rd_place_medal.png',
                        '@jihan65',
                        'Mahasiswa',
                        'Kang Parkir',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}

// Main Feature Card
Widget _buildMainFeatureCard(IconData icon, String title) {
  return Container(
    width: 130,
    height: 180,
    margin: EdgeInsets.symmetric(horizontal: 20),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Color(0xFFFEC827),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 4,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.white,
          child: Icon(icon, size: 40),
        ),
        SizedBox(height: 12),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    ),
  );
}

// Features
Widget _buildFeatures(context, Widget page, IconData icon, String title) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: Icon(icon, size: 32),
          ),
        ),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    ),
  );
}

// Leaderboard Card
Widget _buildLeaderboardCard(
  String imagePath,
  String username,
  String status,
  String rank,
) {
  return Container(
    height: 60,
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 3,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        Image.asset(imagePath, width: 45),
        CircleAvatar(
          child: Icon(Icons.person),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                status,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.workspace_premium),
            Text(
              rank,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}