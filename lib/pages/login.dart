import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Halaman Login'),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Back to Halaman Awal"))
          ],
        ),
      ),
    );
  }
}
