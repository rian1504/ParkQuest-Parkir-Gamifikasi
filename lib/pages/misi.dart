import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkquest_parkir_gamifikasi/Models/mission.dart';
import 'package:parkquest_parkir_gamifikasi/widgets/navigation_bar.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/mission_controller.dart';

class Misi extends StatefulWidget {
  const Misi({super.key});

  @override
  State<Misi> createState() => _MisiState();
}

class _MisiState extends State<Misi> {
  // Mission
  final MissionController _missioncontroller = Get.put(MissionController());

  @override
  void initState() {
    super.initState();
    _missioncontroller.index();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
        automaticallyImplyLeading: false,
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
        child: Obx(() {
          if (_missioncontroller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _missioncontroller.datas.value.length,
              itemBuilder: (context, index) {
                final MissionModel data = _missioncontroller.datas.value[index];

                return ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Obx(() {
                      if (_missioncontroller.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (index == 0) {
                        return GestureDetector(
                          onTap: () => _showLoginPopup(
                            context,
                            data.streak,
                            data.updatedAt,
                          ),
                          child: _buildMissionCard(
                            title: "Daily",
                            subtitle: "Login",
                            icon: CupertinoIcons.calendar,
                            progress: data.streak,
                            total: 7,
                          ),
                        );
                      }

                      if (index == 1) {
                        return Column(
                          children: [
                            SizedBox(height: 16),
                            _buildMissionCard(
                              title: 'Weekly',
                              subtitle: data.mission.missionDescription,
                              icon: CupertinoIcons.star,
                              // progressPercentage: data.streak,
                              // isPercentage: true,
                              progress: data.streak,
                              total: 5,
                            ),
                          ],
                        );
                      }

                      if (index == 2) {
                        return Column(
                          children: [
                            SizedBox(height: 16),
                            _buildMissionCard(
                              title: 'Lifetime',
                              subtitle: data.mission.missionDescription,
                              icon: CupertinoIcons.person_add,
                              progress: data.streak,
                              total: 3,
                            ),
                          ],
                        );
                      }

                      return Text('No mission available');
                    }),
                  ],
                );
              });
        }),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
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

  void _showLoginPopup(BuildContext context, int streak, DateTime updatedAt) {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (context) {
        // Daftar hadiah misi
        final rewards = [1, 1, 1, 3, 3, 3, 5];

        // Ambil tanggal hari ini tanpa memperhitungkan waktu
        final currentDate = DateTime.now();
        final today =
            DateTime(currentDate.year, currentDate.month, currentDate.day);

        // Cek jika hari ini sudah login berdasarkan updatedAt
        final updatedDateOnly =
            DateTime(updatedAt.year, updatedAt.month, updatedAt.day);

        // Jika streak 0
        final isTodayLogin =
            streak == 0 ? false : today.isAtSameMomentAs(updatedDateOnly);

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Color(0xFFFFD858),
          child: SafeArea(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Grid untuk Day 1 sampai Day 6
                      Expanded(
                        flex: 2,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.4,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 6,
                          ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            final isActive = streak == index;
                            final isButtonDisabled = isTodayLogin || !isActive;

                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: isButtonDisabled
                                      ? null
                                      : () async {
                                          await _missioncontroller.dailyLogin(
                                            onSuccess: () {
                                              Navigator.of(context).pop();
                                              _showClaimSuccessPopup(context);
                                              _missioncontroller.index();
                                            },
                                          );
                                        },
                                  child: Column(
                                    children: [
                                      Text(
                                        'Day ${index + 1}',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Container(
                                        height: 80,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: isButtonDisabled
                                              ? Colors.white
                                              : Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/img/coin.png',
                                            ),
                                            Text(
                                              '${rewards[index]} Koin',
                                              style: GoogleFonts.inter(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 6),
                      // Elemen untuk Day 7
                      GestureDetector(
                        onTap: isTodayLogin || streak != 6
                            ? null
                            : () async {
                                await _missioncontroller.dailyLogin(
                                  onSuccess: () {
                                    Navigator.of(context).pop();
                                    _showClaimSuccessPopup(context);
                                    _missioncontroller.index();
                                  },
                                );
                              },
                        child: Column(
                          children: [
                            Text(
                              'Day 7',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Container(
                              height: 200,
                              width: 100,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: isTodayLogin || streak != 6
                                    ? Colors.white
                                    : Colors.blue,
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
                                    '${rewards[6]} Koin',
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
