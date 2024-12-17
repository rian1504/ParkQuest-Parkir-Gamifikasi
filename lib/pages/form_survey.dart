import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class FormSurvey extends StatefulWidget {
  const FormSurvey({super.key});

  @override
  State<FormSurvey> createState() => _FormSurveyState();
}

class _FormSurveyState extends State<FormSurvey> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
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
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            CupertinoIcons.chevron_left,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Gedung Utama',
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
                      if (snapshot.connectionState == ConnectionState.done) {
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
            Expanded(
              child: ListView(
                children: [
                  const QuestionInputField(
                      question:
                          'Seberapa mudah menurut Anda menemukan tempat parkir di area ini?'),
                  const QuestionInputField(
                      question:
                          'Berapa lama biasanya Anda membutuhkan waktu untuk menemukan tempat parkir?'),
                  const QuestionInputField(
                      question:
                          'Apa yang paling Anda harapkan dari peningkatan fasilitas parkir di kampus?'),
                  const QuestionInputField(
                      question:
                          'Apa yang paling Anda harapkan dari peningkatan fasilitas parkir di kampus?'),
                  const QuestionInputField(
                      question:
                          'Apa yang paling Anda harapkan dari peningkatan fasilitas parkir di kampus?'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    showSuccessDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFEC827),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
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
        ),
      ),
    );
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'img/clapsuccess.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 16),
              const Text(
                'Yeayyy !!! Kamu berhasil mendapatkan 10 exp',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class QuestionInputField extends StatelessWidget {
  final String question;

  const QuestionInputField({super.key, required this.question});

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
