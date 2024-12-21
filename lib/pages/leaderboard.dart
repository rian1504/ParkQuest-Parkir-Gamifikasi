import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/leaderboard_controller.dart';
import 'package:parkquest_parkir_gamifikasi/models/leaderboard/leaderboard.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  // Leaderboard
  final LeaderboardController _leaderboardcontroller =
      Get.put(LeaderboardController());

  // Leaderrboard Podium
  Widget _buildPodium(
    Widget avatar,
    String image,
    String username,
    double height,
    Color color,
  ) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              child: avatar,
            ),
            Image.asset(
              image,
              width: 45,
            )
          ],
        ),
        SizedBox(height: 10),
        Text(
          username,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: height,
          width: 100,
          decoration: BoxDecoration(
            color: color,
          ),
        ),
      ],
    );
  }

  // Card
  Widget _buildCard(
      Widget avatar, String username, String status, String rank) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                child: avatar,
              ),
            ],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  status,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.workspace_premium, size: 20),
                  Text(
                    rank,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
        title: Text(
          'Leaderboard',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Obx(() {
            final data = _leaderboardcontroller.dataUserLeaderboard.value!;

            return _leaderboardcontroller.isLoading.value
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      // Profile Greeting
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Greeting
                          Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/img/waving_hand.png',
                                    width: 40,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hi ${data.user.name},',
                                        style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Great to see you again',
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Profile
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                child: data.user.avatar == null
                                    ? Icon(Icons.person)
                                    : Image.network(
                                        storageUrl + data.user.avatar,
                                      ),
                                // child: IconButton(
                                //   icon: Icon(Icons.person),
                                //   onPressed: () {
                                //     Navigator.pushNamed(context, '/profile');
                                //   },
                                // ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Container
                      GestureDetector(
                        onTap: () {
                          // Functionality for showing rank details
                        },
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.workspace_premium, size: 32),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.rank.rankName,
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '${data.user.totalExp} exp',
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/img/trophy.png',
                                    height: 32,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '#1',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Leaderboard Title
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Leaderboard',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Top 3 Leaderboard Podium
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Obx(() {
                          return _leaderboardcontroller.isLoading.value
                              ? CircularProgressIndicator()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _leaderboardcontroller
                                      .datasTopThree.value.length,
                                  itemBuilder: (context, index) {
                                    // Map the index to the desired order
                                    int mappedIndex;
                                    if (index == 0) {
                                      mappedIndex = 1;
                                    } else if (index == 1) {
                                      mappedIndex = 0;
                                    } else {
                                      mappedIndex = 2;
                                    }

                                    final LeaderboardModel data =
                                        _leaderboardcontroller
                                            .datasTopThree.value[index];

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        _buildPodium(
                                          data.user.avatar == null
                                              ? Icon(Icons.person)
                                              : Image.network(
                                                  storageUrl + data.user.avatar,
                                                ),
                                          mappedIndex == 0
                                              ? 'assets/img/2_place_medal.png'
                                              : mappedIndex == 1
                                                  ? 'assets/img/1_place_medal.png'
                                                  : 'assets/img/3_place_medal.png',
                                          data.user.username,
                                          100,
                                          mappedIndex == 0
                                              ? Color(0xFFFECE2E)
                                              : mappedIndex == 1
                                                  ? Color(0xFFFFB636)
                                                  : Color(0xFFFFEC4C),
                                        ),
                                      ],
                                    );
                                  });
                        }),
                      ),
                      SizedBox(height: 20),
                      // Leaderboard List
                      SingleChildScrollView(
                        child: Expanded(
                          child: Obx(() {
                            return _leaderboardcontroller.isLoading.value
                                ? CircularProgressIndicator()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _leaderboardcontroller
                                        .datasLeaderboard.value.length,
                                    itemBuilder: (context, index) {
                                      final LeaderboardModel data =
                                          _leaderboardcontroller
                                              .datasLeaderboard.value[index];
                                      return _buildCard(
                                        data.user.avatar == null
                                            ? Icon(Icons.person)
                                            : Image.network(
                                                storageUrl + data.user.avatar,
                                              ),
                                        data.user.username,
                                        'Mahasiswa',
                                        data.rank.rankName,
                                      );
                                    });
                          }),
                        ),
                      ),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
