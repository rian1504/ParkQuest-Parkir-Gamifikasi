import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:show_hide_password/show_hide_password.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/authentication_controller.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _roleId = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  String? selectedValue;

  @override
  void dispose() {
    _roleId.dispose();
    super.dispose();
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
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Card
                      Container(
                        margin: EdgeInsets.only(top: 200),
                        height: 560,
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 50),
                            Text(
                              'Login',
                              style: GoogleFonts.inter(
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 30),
                            // Role Dropdown
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: DropdownButtonFormField<String>(
                                dropdownColor: Colors.white,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                ),
                                items: [
                                  DropdownMenuItem<String>(
                                    value: '1',
                                    child: Text(
                                      'Internal',
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: '2',
                                    child: Text(
                                      'Eksternal',
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                                hint: Text(
                                  "Role",
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue;
                                    _roleId.text = newValue!;
                                  });
                                },
                                value: selectedValue,
                              ),
                            ),
                            SizedBox(height: 15),
                            // Username Field
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: TextFormField(
                                controller: _username,
                                decoration: InputDecoration(
                                  labelText: "Username",
                                  labelStyle: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            // Password Field
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ShowHidePassword(
                                hidePassword: true,
                                passwordField: (hidePassword) {
                                  return TextField(
                                    controller: _password,
                                    obscureText: hidePassword,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      labelStyle: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                      ),
                                    ),
                                  );
                                },
                                iconSize: 20,
                                visibleOffIcon: CupertinoIcons.eye_slash,
                                visibleOnIcon: CupertinoIcons.eye,
                              ),
                            ),
                            SizedBox(height: 25),
                            // Login Button
                            SizedBox(
                              height: 50,
                              width: 175,
                              child: TextButton(
                                onPressed: () async {
                                  await _authenticationController.login(
                                      roleId: _roleId.text,
                                      username: _username.text.trim(),
                                      password: _password.text.trim(),
                                      onSuccess: () {
                                        _roleId.clear();
                                        _username.clear();
                                        _password.clear();
                                      });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFFFEC827),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            // Daftar Button
                            Text(
                              'Belum punya akun?',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                'Daftar',
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
                      // Image
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Image.asset(
                            "assets/img/login.png",
                            height: 250,
                          ),
                        ),
                      ),
                    ],
                  ),
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
