import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:parkquest_parkir_gamifikasi/Models/Leaderboard/Leaderboard.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/authentication_controller.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/leaderboard_controller.dart';
import 'package:parkquest_parkir_gamifikasi/widgets/navigation_bar.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Leaderboard
  final LeaderboardController _leaderboardcontroller =
      Get.put(LeaderboardController());

  // Data user
  final AuthenticationController _authenticationcontroller =
      Get.put(AuthenticationController());

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
                    child: Obx(() {
                      final user = _authenticationcontroller.user.value!;

                      return _authenticationcontroller.isLoading.value
                          ? CircularProgressIndicator()
                          : Row(
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  child: user.avatar == null
                                      ? Icon(Icons.person)
                                      : Image.network(storageUrl + user.avatar),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hello, ${user.name}',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        user.username,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '${user.totalExp.toString()} EXP',
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
                                      '${user.coin.toString()} Coins',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            );
                    }),
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
                          Navigator.pushNamed(
                            context,
                            '/pencarian_parkir',
                          );
                        },
                        child: _buildMainFeatureCard(
                          CupertinoIcons.search,
                          'Cari Parkir',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/rekomendasi_parkir',
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
                        '/survey',
                        CupertinoIcons.doc_plaintext,
                        'Survey',
                      ),
                      // Shop
                      _buildFeatures(
                        context,
                        '/shop',
                        CupertinoIcons.cart,
                        'Shop',
                      ),
                      // Misi
                      _buildFeatures(
                        context,
                        '/misi',
                        CupertinoIcons.game_controller,
                        'Misi',
                      ),
                      // Inventory
                      _buildFeatures(
                        context,
                        '/inventory',
                        CupertinoIcons.archivebox,
                        'Inventory',
                      ),
                      // Kode Referral
                      _buildFeatures(
                        context,
                        '/kode_referral',
                        CupertinoIcons.person_add,
                        'Kode Referral',
                      ),
                      // Leaderboard
                      _buildFeatures(
                        context,
                        '/leaderboard',
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
                  Obx(() {
                    return _leaderboardcontroller.isLoading.value
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _leaderboardcontroller
                                .datasTopThree.value.length,
                            itemBuilder: (context, index) {
                              final data = _leaderboardcontroller
                                  .datasTopThree.value[index];

                              return ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  _buildLeaderboardCard(
                                    'assets/img/${index + 1}_place_medal.png',
                                    data.user.avatar == null
                                        ? Icon(Icons.person)
                                        : Image.network(
                                            storageUrl + data.user.avatar,
                                          ),
                                    data.user.username,
                                    'Mahasiswa',
                                    data.rank.rankName,
                                  ),
                                ],
                              );
                            });
                  }),
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
    margin: EdgeInsets.symmetric(horizontal: 15),
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
Widget _buildFeatures(context, String page, IconData icon, String title) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        page,
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
  Widget avatar,
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
          child: avatar,
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
