import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/LeaderboardController.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Leaderboard.dart';

class Leaderboard extends StatelessWidget {
  Leaderboard({super.key});

  // Leaderboard
  final LeaderboardController _leaderboardcontroller =
      Get.put(LeaderboardController());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');

    if (token == null) {
      Future.microtask(() {
        Navigator.pushNamed(context, '/login');
      });
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Leaderboard'),
            Obx(() {
              return _leaderboardcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _leaderboardcontroller.datas.value.length,
                      itemBuilder: (context, index) {
                        final LeaderboardModel data =
                            _leaderboardcontroller.datas.value[index];
                        return Column(
                          children: [
                            Text(data.username),
                            Text(data.rank.rankName.toString()),
                          ],
                        );
                      },
                    );
            }),
          ],
        ),
      ),
    );
  }
}
