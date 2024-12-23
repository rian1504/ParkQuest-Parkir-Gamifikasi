import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:show_hide_password/show_hide_password.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/authentication_controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _selectedRole = "internal";

  final _name = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _identityNumber = TextEditingController();
  final _company = TextEditingController();
  final _position = TextEditingController();
  final _password = TextEditingController();
  final _authenticationController = Get.put(AuthenticationController());

  // Card
  Widget _buildCard(double height) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 50),
      width: double.infinity,
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
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                if (_selectedRole == 'internal') {
                  await _authenticationController.registerInternal(
                      roleId: 1.toString(),
                      name: _name.text.trim(),
                      username: _username.text.trim(),
                      email: _email.text.trim(),
                      identityNumber: _identityNumber.text.trim(),
                      password: _password.text.trim(),
                      onSuccess: () {
                        // Membersihkan field
                        _name.clear();
                        _username.clear();
                        _email.clear();
                        _identityNumber.clear();
                        _password.clear();

                        // Memanggil success dialog
                        _showSuccessDialog();
                      });
                }

                if (_selectedRole == 'eksternal') {
                  await _authenticationController.registerEksternal(
                      roleId: 2.toString(),
                      name: _name.text.trim(),
                      username: _username.text.trim(),
                      email: _email.text.trim(),
                      identityNumber: _identityNumber.text.trim(),
                      company: _company.text.trim(),
                      position: _position.text.trim(),
                      password: _password.text.trim(),
                      onSuccess: () {
                        // Membersihkan field
                        _name.clear();
                        _username.clear();
                        _email.clear();
                        _identityNumber.clear();
                        _company.clear();
                        _position.clear();
                        _password.clear();

                        // Memanggil success dialog
                        _showSuccessDialog();
                      });
                }
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
                  fontWeight: FontWeight.bold,
                ),
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
    );
  }

  // Text Form Field
  Widget _buildTextFormField(String label, TextEditingController controller,
      TextInputType keyboardType) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
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
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
      ),
    );
  }

  // Password Field
  Widget _buildPasswordField(String label, TextEditingController controller) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ShowHidePassword(
        hidePassword: true,
        passwordField: (hidePassword) {
          return TextField(
            controller: controller,
            obscureText: hidePassword,
            decoration: InputDecoration(
              labelText: label,
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
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
          );
        },
        iconSize: 20,
        visibleOffIcon: CupertinoIcons.eye_slash,
        visibleOnIcon: CupertinoIcons.eye,
      ),
    );
  }

  // Form Internal
  Widget _buildInternalForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 25),
          _buildTextFormField('Nama', _name, TextInputType.text),
          SizedBox(height: 15),
          _buildTextFormField('Username', _username, TextInputType.text),
          SizedBox(height: 15),
          _buildTextFormField(
              'NIM/NIK/NIDN', _identityNumber, TextInputType.number),
          SizedBox(height: 15),
          _buildTextFormField('Email', _email, TextInputType.emailAddress),
          SizedBox(height: 15),
          _buildPasswordField('Password', _password),
        ],
      ),
    );
  }

  // Form Eksternal
  Widget _buildEksternalForm() {
    return Column(
      children: [
        SizedBox(height: 25),
        _buildTextFormField('Nama', _name, TextInputType.text),
        SizedBox(height: 15),
        _buildTextFormField('Username', _username, TextInputType.text),
        SizedBox(height: 15),
        _buildTextFormField(
            'No KTP/NIK', _identityNumber, TextInputType.number),
        SizedBox(height: 15),
        _buildTextFormField(
            'Instansi/Perusahaan', _company, TextInputType.text),
        SizedBox(height: 15),
        _buildTextFormField('Jabatan', _position, TextInputType.text),
        SizedBox(height: 15),
        _buildTextFormField('Email', _email, TextInputType.emailAddress),
        SizedBox(height: 15),
        _buildPasswordField('Password', _password),
      ],
    );
  }

  // Success Dialog
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
                        'assets/img/success_checked.png',
                        width: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Registrasi Berhasil!',
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
                        Navigator.pushNamed(context, '/login');
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
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image
                      Column(
                        children: [
                          SizedBox(
                            child: Image.asset(
                              "assets/img/register.png",
                              height: 180,
                              width: 85,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      // Text Registrasi
                      Column(
                        children: [
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
                    ],
                  ),
                  // Memanggil Card
                  if (_selectedRole == 'internal') _buildCard(580),
                  if (_selectedRole == 'eksternal') _buildCard(720),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper untuk Curved Background
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
