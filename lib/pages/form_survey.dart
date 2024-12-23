import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/survey_controller.dart';
import 'package:parkquest_parkir_gamifikasi/models/survey/survey_detail.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';

class FormSurvey extends StatefulWidget {
  const FormSurvey({super.key});

  @override
  State<FormSurvey> createState() => _FormSurveyState();
}

class _FormSurveyState extends State<FormSurvey> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  // Survey
  final SurveyController _surveycontroller = Get.put(SurveyController());

  // Answer Storage
  final Map<int, TextEditingController> _answerControllers = {};

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        storageUrl + _surveycontroller.datasDetail.value[0].surveyVideo,
      ),
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
        title: Text(
          'Form Survey',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            CupertinoIcons.chevron_left,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
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

            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _surveycontroller.datasDetail.value.length,
                itemBuilder: (context, index) {
                  final SurveyDetailModel data =
                      _surveycontroller.datasDetail.value[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        data.surveyName,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Video
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            FutureBuilder(
                              future: _initializeVideoPlayerFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(_controller),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }
                                });
                              },
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                              style: IconButton.styleFrom(
                                backgroundColor: Color(0xFFFEC827),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Form
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ...data.question.map((q) {
                            return QuestionInputField(
                              question: q.question,
                              controller: _answerControllers[q.id] ??
                                  TextEditingController(),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              _submitAnswers(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFEC827),
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                            ),
                            child: Text(
                              'Submit',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
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
      onSuccess: () {
        _showSuccessDialog();
        _answerControllers.clear();
      },
    );
  }

  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/img/success_clap.png',
                        width: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Yeayyy !!! Kamu berhasil mendapatkan 15 exp',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/dashboard');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF24E1E),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class QuestionInputField extends StatelessWidget {
  final String question;
  final TextEditingController controller;

  const QuestionInputField({
    super.key,
    required this.question,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
