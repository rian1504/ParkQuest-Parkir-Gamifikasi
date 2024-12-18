import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/leaderboard_controller.dart';
import 'package:parkquest_parkir_gamifikasi/models/leaderboard/leaderboard.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class Leaderboard extends StatefulWidget {
  Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  // Leaderboard
  final LeaderboardController _leaderboardcontroller =
      Get.put(LeaderboardController());

  // @override
  // void initState() {
  //   super.initState();
  //   // _leaderboardcontroller.leaderboard();
  //   // _leaderboardcontroller.userLeaderboard();
  // }

  @override
  Widget build(BuildContext context) {
    // final box = GetStorage();
    // final token = box.read('token');

    // if (token == null) {
    //   Future.microtask(() {
    //     Navigator.pushNamed(context, '/login');
    //   });
    // }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                final data = _leaderboardcontroller.dataUserLeaderboard.value!;

                return _leaderboardcontroller.isLoading.value
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          Text(data.user.name),
                          data.user.avatar == null
                              ? Image(image: AssetImage('assets/img/user.png'))
                              : Image.network(
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
                        itemCount: _leaderboardcontroller
                            .datasLeaderboard.value.length,
                        itemBuilder: (context, index) {
                          final LeaderboardModel data = _leaderboardcontroller
                              .datasLeaderboard.value[index];

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
