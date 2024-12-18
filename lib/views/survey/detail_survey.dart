import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/survey_controller.dart';
import 'package:parkquest_parkir_gamifikasi/models/survey/survey_detail.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class DetailSurvey extends StatelessWidget {
  DetailSurvey({super.key});

  // Survey
  final SurveyController _surveycontroller = Get.put(SurveyController());

  // Answer Storage
  final Map<int, TextEditingController> _answerControllers = {};

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
        child: Obx(() {
          if (_surveycontroller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final surveyDetails = _surveycontroller.datasDetail.value;

          // Initialize controllers for each question
          for (var detail in surveyDetails) {
            for (var question in detail.question) {
              _answerControllers[question.id] =
                  TextEditingController(); // Create controller for each question
            }
          }

          // Gunakan ListView sebagai widget utama
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _surveycontroller.datasDetail.value.length,
            itemBuilder: (context, index) {
              final SurveyDetailModel data =
                  _surveycontroller.datasDetail.value[index];

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.surveyName,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Image.network(storageUrl + data.surveyImage),
                        SizedBox(height: 16),
                        Text(
                          'Questions:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ...data.question.map((q) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(q.question),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: _answerControllers[q.id],
                                  decoration: InputDecoration(
                                    hintText: "Masukkan jawaban Anda",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            _submitAnswers(context);
            _answerControllers.clear();
          },
          child: Text("Submit"),
        ),
      ),
    );
  }

  void _submitAnswers(BuildContext context) {
    final surveyId = _surveycontroller.datasDetail.value[0].id;
    final answers = _answerControllers.entries.map((entry) {
      return {
        "question_id": entry.key,
        "answer": entry.value.text,
      };
    }).toList();

    // Kirim jawaban ke SurveyController
    _surveycontroller.submit(
      surveyId: surveyId,
      answers: answers,
    );

    // Tampilkan dialog konfirmasi atau navigasi
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Hasil Survey"),
        content: Text("Jawaban telah dikirim."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
