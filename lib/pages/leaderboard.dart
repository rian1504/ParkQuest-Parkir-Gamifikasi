import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  // Leaderrboard Podium
  Widget _buildPodium(
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
              child: Icon(Icons.person),
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
  Widget _buildCard(String username, String status, String rank) {
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
                child: Icon(Icons.person),
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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi Elys,',
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
                      child: IconButton(
                        icon: Icon(Icons.person),
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Kang Parkir',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '500 exp',
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Second Place
                  _buildPodium(
                    'assets/img/2nd_place_medal.png',
                    'jihan65',
                    100,
                    Color(0xFFFECE2E),
                  ),
                  // First Place
                  _buildPodium(
                    'assets/img/1st_place_medal.png',
                    'jihan65',
                    150,
                    Color(0xFFFFB636),
                  ),
                  // Third Place
                  _buildPodium(
                    'assets/img/3rd_place_medal.png',
                    'jihan65',
                    50,
                    Color(0xFFFFEC4C),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Leaderboard List
            Expanded(
              child: ListView(
                children: List.generate(5, (index) {
                  return _buildCard('jihan65', 'Mahasiswa', 'Kang Parkir');
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
