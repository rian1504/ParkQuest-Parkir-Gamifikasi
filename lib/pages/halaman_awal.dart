import 'package:flutter/material.dart';

class HalamanAwal extends StatefulWidget {
  const HalamanAwal({super.key});

  @override
  State<HalamanAwal> createState() => _HalamanAwalState();
}

class _HalamanAwalState extends State<HalamanAwal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFEC827),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 112,
              ),
              Text(
                'ParkQuest',
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              Image.asset("assets/img/halaman_awal.png"),
              SizedBox(height: 57),
              Text(
                'Siap jadi King Parkir?',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Text(
                'Login dan kumpulkan reward-mu sekarang',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                width: 174,
                height: 51,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/daftar');
                  },
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(height: 14),
              Container(
                width: 174,
                height: 51,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(200))),
                child: Column(),
              ),
            ],
          ),
        ));
  }
}
