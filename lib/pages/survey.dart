import 'package:flutter/material.dart';

void main() {
  runApp(Survey());
}

class Survey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[700],
          title: Text('Survey', style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              buildSurveyCard('Gedung Utama', 'assets/img/login.png'),
              buildSurveyCard('Technopreneur', 'assets/img/login.png'),
              buildSurveyCard('Tower A', 'assets/img/login.png'),
            ],
          ),
        ),
      ),
    );
  }

  // Function to create each survey card
  Widget buildSurveyCard(String title, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
