import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/AuthenticationController.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/LeaderboardController.dart';
import 'package:parkquest_parkir_gamifikasi/views/widgets/leaderboard_top_three.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  // Logout
  final _formKey = GlobalKey<FormState>();
  final _authenticationController = Get.put(AuthenticationController());

  // Leaderboard
  final LeaderboardController _leaderboardController =
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
            Obx(() {
              return _leaderboardController.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _leaderboardController.datas.value.length,
                      itemBuilder: (context, index) {
                        return LeaderboardTopThree(
                          data: _leaderboardController.datas.value[index],
                        );
                      },
                    );
            }),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _authenticationController.logout();
                    },
                    child: Obx(() {
                      return _authenticationController.isLoading.value
                          ? CircularProgressIndicator()
                          : Text('Logout');
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
