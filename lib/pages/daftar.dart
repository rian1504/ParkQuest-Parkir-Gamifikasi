import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:show_hide_password/show_hide_password.dart';

class Daftar extends StatefulWidget {
  const Daftar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  var _selectedRole = "internal";

  // Card
  Widget _cardForm(double height) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: Container(
        padding: EdgeInsets.all(20),
        width: 320,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Button Internal
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedRole = 'internal';
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: _selectedRole == 'internal'
                          ? Color(0xFFFEC827)
                          : Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: Text(
                      'Internal',
                      style: GoogleFonts.inter(
                        color: _selectedRole == 'internal'
                            ? Colors.white
                            : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30),
                // Button Eksternal
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedRole = 'eksternal';
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: _selectedRole == 'eksternal'
                          ? Color(0xFFFEC827)
                          : Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: Text(
                      'Eksternal',
                      style: GoogleFonts.inter(
                          color: _selectedRole == 'eksternal'
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            // Form Fields
            if (_selectedRole == 'internal') _buildInternalForm(),
            if (_selectedRole == 'eksternal') _buildEksternalForm(),
            // Submit Button
            SizedBox(height: 25),
            SizedBox(
              height: 50,
              width: 500,
              child: TextButton(
                onPressed: () {
                  // Handle submit action
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFFEC827),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Daftar',
                  style: GoogleFonts.inter(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Sudah punya akun?',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Login',
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Form Internal
  Widget _buildInternalForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 25),
          SizedBox(
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Nama",
                  labelStyle: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  )),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  )),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "NIM/NIK/NIDN",
                  labelStyle: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  )),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  )),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            height: 50,
            child: ShowHidePassword(
              hidePassword: true,
              passwordField: (hidePassword) {
                return TextField(
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      )),
                );
              },
              iconSize: 20,
              visibleOffIcon: FluentIcons.eye_off_32_filled,
              visibleOnIcon: FluentIcons.eye_32_filled,
            ),
          ),
        ],
      ),
    );
  }

  // Form Eksternal
  Widget _buildEksternalForm() {
    return Column(
      children: [
        SizedBox(height: 25),
        SizedBox(
          height: 50,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Nama",
              labelStyle: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 50,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Username",
              labelStyle: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 50,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "No KTP/NIK",
              labelStyle: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 50,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Instansi/Perusahaan",
              labelStyle: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 50,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Jabatan",
              labelStyle: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 50,
          child: ShowHidePassword(
            hidePassword: true,
            passwordField: (hidePassword) {
              return TextField(
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              );
            },
            iconSize: 20,
            visibleOffIcon: FluentIcons.eye_off_32_filled,
            visibleOnIcon: FluentIcons.eye_32_filled,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Curved Background
          ClipPath(
            clipper: RoundedClipper(),
            child: Container(
              height: 500,
              decoration: BoxDecoration(color: Color(0xFFFEC827)),
            ),
          ),
          // Main Content
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    children: [
                      // Image Registrasi
                      Padding(padding: EdgeInsets.only(left: 25)),
                      Image.asset(
                        "assets/img/register.png",
                        height: 180,
                        width: 85,
                      ),
                      // Text Registrasi
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        'Registrasi',
                        style: GoogleFonts.inter(
                          fontSize: 40,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Memanggil Card
                  if (_selectedRole == 'internal') _cardForm(580),
                  if (_selectedRole == 'eksternal') _cardForm(720),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom clipper untuk curved background
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
