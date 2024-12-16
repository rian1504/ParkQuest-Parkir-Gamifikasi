import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/survey_controller.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Survey/Survey.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class Survey extends StatelessWidget {
  Survey({super.key});

  // Survey
  final SurveyController _surveycontroller = Get.put(SurveyController());

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
            Text('Survey'),
            Obx(() {
              return _surveycontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _surveycontroller.datas.value.length,
                      itemBuilder: (context, index) {
                        final SurveyModel data =
                            _surveycontroller.datas.value[index];

                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await _surveycontroller.detail(
                                  surveyId: data.id.toString(),
                                );
                              },
                              child: Text(data.surveyName),
                            ),
                            Text(data.id.toString()),
                            Text(data.surveyName),
                            Image.network(
                              storageUrl + data.surveyImage,
                              width: 100,
                              height: 100,
                            ),
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
