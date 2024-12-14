import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/LeaderboardController.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Leaderboard/Leaderboard.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Leaderboard/UserLeaderboard.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                final UserLeaderboardModel data =
                    _leaderboardcontroller.dataUserLeaderboard.value!;
                debugPrint(data.toString());

                return _leaderboardcontroller.isLoading.value
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          Text(data.user.name),
                          Image.network(
                            storageUrl + data.user.avatar,
                            width: 100,
                            height: 100,
                          ),
                          Text(data.rank.rankName),
                        ],
                      );
              }),
              Text('Leaderboard'),
              Text('Top Three'),
              Obx(() {
                return _leaderboardcontroller.isLoading.value
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            _leaderboardcontroller.datasTopThree.value.length,
                        itemBuilder: (context, index) {
                          final LeaderboardModel data =
                              _leaderboardcontroller.datasTopThree.value[index];
                          return Column(
                            children: [
                              Text(data.user.username),
                              Text(data.rank.rankName),
                            ],
                          );
                        },
                      );
              }),
              Text('All'),
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
                              Text(data.user.username),
                              Text(data.rank.rankName),
                            ],
                          );
                        },
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
