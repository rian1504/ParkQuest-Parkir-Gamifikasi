import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Misi extends StatefulWidget {
  const Misi({super.key});

  @override
  State<Misi> createState() => _MisiState();
}

class _MisiState extends State<Misi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
        title: Center(
          child: Text(
            'Misi',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () => _showLoginPopup(context),
              child: _buildMissionCard(
                title: "Daily",
                subtitle: "Login",
                icon: CupertinoIcons.calendar,
                progress: 3,
                total: 7,
              ),
            ),
            SizedBox(height: 16),
            _buildMissionCard(
              title: "Weekly",
              subtitle: "Rekomendasi",
              icon: CupertinoIcons.star,
              progressPercentage: 70,
              isPercentage: true,
            ),
            SizedBox(height: 16),
            _buildMissionCard(
              title: "Lifetime",
              subtitle: "Undang Teman",
              icon: CupertinoIcons.person_add,
              progress: 1,
              total: 3,
            ),
          ],
        ),
      ),
    );
  }

  // Card
  Widget _buildMissionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    int? progress,
    int? total,
    int? progressPercentage,
    bool isPercentage = false,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.black),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(icon, size: 40),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: isPercentage
                                  ? (progressPercentage ?? 0) / 100
                                  : (progress ?? 0) / (total ?? 1),
                              backgroundColor: Colors.grey[200],
                              color: Color(0xFF37D42A),
                              minHeight: 8,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          if (!isPercentage)
                            Text(
                              '$progress / $total',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          if (isPercentage)
                            Text(
                              '$progressPercentage%',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showLoginPopup(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Color(0xFFFFD858),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        childAspectRatio: 0.5,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        children: List.generate(6, (index) {
                          return _buildDayReward(index + 1, context);
                        }),
                      ),
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      flex: 1,
                      child: _buildBigDayReward(7, context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDayReward(int day, BuildContext context) {
    int coinReward = (day < 4) ? 1 : 3;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        _showClaimSuccessPopup(context);
      },
      child: Column(
        children: [
          Text(
            'Day $day',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/coin.png',
                  width: 40,
                ),
                Text(
                  '$coinReward Koin',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBigDayReward(int day, BuildContext context) {
    int coinReward = 5;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        _showClaimSuccessPopup(context);
      },
      child: Column(
        children: [
          Text(
            'Day $day',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/coin.png',
                  width: 50,
                ),
                Text(
                  '$coinReward Koin',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showClaimSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Checkmark Icon
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80,
                ),
                const SizedBox(height: 20),
                // Success Text
                const Text(
                  "Claim Berhasil!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
