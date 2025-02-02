import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/authentication_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

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
  bool _passwordVisible = false;

  @override
  void dispose() {
    _roleId.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _authenticationController.resetErrors();
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
                            Obx(() {
                              return SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  dropdownColor: Colors.white,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    errorText: _authenticationController
                                            .roleIdError.isNotEmpty
                                        ? _authenticationController
                                            .roleIdError.value
                                        : null,
                                    errorStyle: GoogleFonts.inter(
                                      fontSize: 8,
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
                                      _authenticationController
                                          .roleIdError.value = '';
                                    });
                                  },
                                  value: selectedValue,
                                ),
                              );
                            }),
                            SizedBox(height: 15),
                            // Username Field
                            Obx(() {
                              return SizedBox(
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
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                    ),
                                    errorText: _authenticationController
                                            .usernameError.isNotEmpty
                                        ? _authenticationController
                                            .usernameError.value
                                        : null,
                                    errorStyle: GoogleFonts.inter(
                                      fontSize: 8,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _authenticationController
                                        .usernameError.value = '';
                                  },
                                ),
                              );
                            }),
                            SizedBox(height: 15),
                            // Password Field
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: Obx(() {
                                return TextField(
                                  controller: _password,
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    labelStyle: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                    ),
                                    errorText: _authenticationController
                                            .passwordError.isNotEmpty
                                        ? _authenticationController
                                            .passwordError.value
                                        : null,
                                    errorStyle: GoogleFonts.inter(
                                      fontSize: 8,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? CupertinoIcons.eye
                                            : CupertinoIcons.eye_slash,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _authenticationController
                                        .passwordError.value = '';
                                  },
                                );
                              }),
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

                                        // Reset errors
                                        _authenticationController.resetErrors();
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
                                _authenticationController.resetErrors();
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
