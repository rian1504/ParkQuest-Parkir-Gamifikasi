import 'package:flutter/material.dart';

class Daftar extends StatelessWidget {
  const Daftar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Halaman Daftar'),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back to Halaman Awal'))
          ],
        ),
      ),
    );
  }
}
