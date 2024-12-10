import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:parkquest_parkir_gamifikasi/Controllers/SurveyController.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Survey/Survey.dart';

class SurveyWidget extends StatelessWidget {
  SurveyWidget({
    super.key,
    required this.data,
  });

  final SurveyModel data;
  // final _formKey = GlobalKey<FormState>();

  // final SurveyController _surveycontroller =
  //     Get.put(SurveyController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          children: [
            // Form(
            //   key: _formKey,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       ElevatedButton(
            //         onPressed: () async {
            //           await _surveycontroller.parkData(
            //               parkAreaId: data.id.toString());
            //         },
            //         child: Obx(() {
            //           return _surveycontroller.isLoading.value
            //               ? CircularProgressIndicator()
            //               : Text(data.parkName);
            //         }),
            //       ),
            //     ],
            //   ),
            // ),
            Text(data.id.toString()),
            Text(data.surveyName),
            Text(data.surveyImage),
          ],
        ),
      ),
    );
  }
}
