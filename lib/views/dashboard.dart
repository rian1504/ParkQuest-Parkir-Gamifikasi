import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/AuthenticationController.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/LeaderboardController.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Leaderboard/Leaderboard.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  // Leaderboard
  final LeaderboardController _leaderboardcontroller =
      Get.put(LeaderboardController());

  // Data user
  final AuthenticationController _authenticationcontroller =
      Get.put(AuthenticationController());

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
            Obx(() {
              final user = _authenticationcontroller.user.value!;
              return _authenticationcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        Text(user.name),
                        Text('${user.totalExp.toString()} EXP'),
                        Text('${user.coin.toString()} Coin'),
                      ],
                    );
            }),
            Text('Dashboard'),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pencarianParkir');
              },
              child: Text('Pencarian Parkir'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/rekomendasiParkir');
              },
              child: Text('Rekomendasi Parkir'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/survey');
              },
              child: Text('Survey'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/shop/basic');
              },
              child: Text('Shop'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/misi');
              },
              child: Text('Misi'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inventory/basic');
              },
              child: Text('Inventory'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/referralBagikan');
              },
              child: Text('Kode Referral'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/leaderboard');
              },
              child: Text('Leaderboard'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/setting');
              },
              child: Text('Setting'),
            ),
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
    );
  }
}
