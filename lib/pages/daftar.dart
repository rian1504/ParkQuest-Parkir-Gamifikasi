import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Daftar extends StatelessWidget {
  const Daftar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ClipPath(
            clipper: RoundedClipper(),
            child: Container(
              height: 500,
              decoration: BoxDecoration(color: Color(0xFFFFD858)),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      // Gambar Registrasi
                      Padding(padding: EdgeInsets.only(left: 25)),
                      Image.asset(
                        "assets/img/register.png",
                        height: 181,
                      ),
                      // Text Registrasi
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        'Registrasi',
                        style: GoogleFonts.inter(
                            fontSize: 40,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // Card
                  Container(
                    padding: EdgeInsets.all(20),
                    width: 320,
                    height: 580,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 5)),
                      ],
                    ),
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFFFFD858),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              child: Text(
                                'Internal',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/daftar2');
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              child: const Text(
                                'Eksternal',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      _buildTextFormField('Nama'),
                      SizedBox(height: 10),
                      _buildTextFormField('Username'),
                      SizedBox(height: 10),
                      _buildTextFormField('NIM/NIK/NIDN'),
                      SizedBox(height: 10),
                      _buildTextFormField('Email'),
                      SizedBox(height: 10),
                      _buildTextFormField('Password'),
                      SizedBox(height: 30),
                      SizedBox(
                        height: 50,
                        width: 500,
                        child: TextButton(
                          onPressed: () {
                            _showSuccessDialog(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFFFD858),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Text(
                            'Daftar',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Sudah punya akun?',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('Login',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                      )
                    ]),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextFormField(String label) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/img/sukses.png', height: 100),
              SizedBox(height: 20),
              Text(
                'Registrasi Berhasil!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the pop-up
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height - 100);

    var firstControlPoint = Offset(size.width / 2, size.height - 200);
    var firstEndPoint = Offset(size.width, size.height - 100);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
