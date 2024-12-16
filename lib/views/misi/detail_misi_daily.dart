import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/mission_controller.dart';

class DetailMisiDaily extends StatelessWidget {
  DetailMisiDaily({super.key});

  // Mission Controller
  final MissionController _missioncontroller = Get.put(MissionController());

  @override
  Widget build(BuildContext context) {
    // Tangkap arguments
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    // Ambil nilai dari arguments
    final streak = arguments['streak'] as int;
    final updatedDate = arguments['updatedAt'] as DateTime;

    // Daftar hadiah misi
    final rewards = [1, 1, 1, 3, 3, 3, 5];

    // Ambil tanggal hari ini tanpa memperhitungkan waktu
    final currentDate = DateTime.now();
    final today = DateTime(currentDate.year, currentDate.month,
        currentDate.day); // Hanya tahun, bulan, dan hari

    // Cek jika hari ini sudah login berdasarkan updatedAt
    final updatedDateOnly = DateTime(updatedDate.year, updatedDate.month,
        updatedDate.day); // Hanya tahun, bulan, dan hari

    // Jika streak 0
    final isTodayLogin =
        streak == 0 ? false : today.isAtSameMomentAs(updatedDateOnly);

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Mission'),
      ),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: rewards.length,
          itemBuilder: (context, index) {
            // Status tombol: hanya tombol yang sesuai dengan streak yang bisa diklik
            final isActive = streak == index;

            // Cek jika tombol harus dinonaktifkan, berdasarkan streak dan apakah sudah login hari ini
            final isButtonDisabled = isTodayLogin || !isActive;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: isButtonDisabled
                    ? null // Disable tombol jika sudah login hari ini atau tidak aktif
                    : () async {
                        await _missioncontroller.dailyLogin();
                        _missioncontroller.index();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButtonDisabled
                      ? Colors.grey // Tombol dinonaktifkan
                      : Colors.blue, // Warna tombol aktif
                ),
                child: Text(
                  '${rewards[index]} koin',
                  style: TextStyle(
                    color: isButtonDisabled ? Colors.black : Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
