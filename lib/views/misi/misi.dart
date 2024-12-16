import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/mission_controller.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Mission.dart';

class Misi extends StatelessWidget {
  Misi({super.key});

  // Mission
  final MissionController _missioncontroller = Get.put(MissionController());

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Misi'),
            Obx(() {
              return _missioncontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _missioncontroller.datas.value.length,
                      itemBuilder: (context, index) {
                        final MissionModel data =
                            _missioncontroller.datas.value[index];

                        return Column(
                          children: [
                            Obx(() {
                              if (_missioncontroller.isLoading.value) {
                                return CircularProgressIndicator();
                              }

                              if (data.mission.missionName == 'Daily Login') {
                                return ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/detailMisiDaily',
                                      arguments: {
                                        'streak': data.streak,
                                        'updatedAt': data.updatedAt,
                                      },
                                    );
                                  },
                                  child: Text('Misi Daily'),
                                );
                              }

                              return Text(data.mission.missionName);
                            }),
                            Text(data.streak.toString()),
                            Text(data.updatedAt.toString()),
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
