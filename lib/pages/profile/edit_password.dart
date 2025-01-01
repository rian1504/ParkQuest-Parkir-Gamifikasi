import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/profile_controller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // Profile
  final ProfileController _profilecontroller = Get.put(ProfileController());

  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _newPasswordConfirmation = TextEditingController();

  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _newPasswordConfirmationVisible = false;

  @override
  initState() {
    super.initState();
    _profilecontroller.profile();
    _oldPasswordVisible = false;
    _newPasswordVisible = false;
    _newPasswordConfirmationVisible = false;
    _profilecontroller.resetErrors();
  }

  // Password Field
  Widget _buildPasswordField(
    String label,
    TextEditingController controller,
    String error,
    bool visible,
    Function() onToggleVisibility,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: TextField(
          controller: controller,
          obscureText: !visible,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            errorText: error.isNotEmpty ? error : null,
            errorStyle: GoogleFonts.inter(
              fontSize: 8,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                visible ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                color: Colors.black,
              ),
              onPressed: onToggleVisibility,
            ),
          ),
        ),
      ),
    );
  }

  // Confirmation Dialog
  Future<void> _showConfirmationDialog() async {
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
                        'assets/img/question_mark.png',
                        width: 200,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Apakah anda yakin?',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: [
            // Button Ya
            Center(
              child: SizedBox(
                width: 130,
                height: 40,
                child: TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _profilecontroller.ubahPassword(
                        oldPassword: _oldPassword.text.trim(),
                        newPassword: _newPassword.text.trim(),
                        newPasswordConfirmation:
                            _newPasswordConfirmation.text.trim(),
                        onSuccess: () {
                          _showSuccessDialog();
                          _oldPassword.clear();
                          _newPassword.clear();
                          _newPasswordConfirmation.clear();
                          _profilecontroller.resetErrors();
                        });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFFEC827),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Ya',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Button Tidak
            Center(
              child: SizedBox(
                width: 130,
                height: 40,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFFEC827),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Tidak',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
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
                        'Kata Sandi Berhasil Diperbarui!',
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
                        Navigator.pushNamed(
                          context,
                          '/profile',
                        );
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
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
        title: Text(
          'Ubah Kata Sandi',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            CupertinoIcons.chevron_left,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Top Right Circle
          Align(
            alignment: Alignment.topRight,
            child: CustomPaint(
              size: Size(150, 150),
              painter: CirclePainterTop(),
            ),
          ),
          // Bottom Left Circle
          Align(
            alignment: Alignment.bottomLeft,
            child: CustomPaint(
              size: Size(150, 150),
              painter: CirclePainterBottom(),
            ),
          ),
          // Card
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: 500,
                margin: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Obx(() {
                        if (_profilecontroller.isLoading.value) {
                          return CircularProgressIndicator();
                        }

                        final user = _profilecontroller.userData.value!;
                        return Column(
                          children: [
                            // Profile Picture
                            CircleAvatar(
                              radius: 40,
                              child: user.avatar == null
                                  ? Icon(Icons.person)
                                  : Image.network(storageUrl + user.avatar),
                            ),
                            SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Akun Saya',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Divider(),
                            // Password Form Field
                            _buildPasswordField(
                              'Password Lama',
                              _oldPassword,
                              _profilecontroller.oldPasswordError.value,
                              _oldPasswordVisible,
                              () {
                                setState(() {
                                  _oldPasswordVisible = !_oldPasswordVisible;
                                });
                              },
                            ),
                            _buildPasswordField(
                              'Password Baru',
                              _newPassword,
                              _profilecontroller.newPasswordError.value,
                              _newPasswordVisible,
                              () {
                                setState(() {
                                  _newPasswordVisible = !_newPasswordVisible;
                                });
                              },
                            ),
                            _buildPasswordField(
                              'Konfirmasi Password',
                              _newPasswordConfirmation,
                              _profilecontroller
                                  .newPasswordConfirmationError.value,
                              _newPasswordConfirmationVisible,
                              () {
                                setState(() {
                                  _newPasswordConfirmationVisible =
                                      !_newPasswordConfirmationVisible;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            // Save Button
                            SizedBox(
                              width: 125,
                              child: TextButton(
                                onPressed: () {
                                  _showConfirmationDialog();
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFFFECE2E),
                                ),
                                child: Text(
                                  'Simpan',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Top Right Circle
class CirclePainterTop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Color(0xFFFFB33B);

    Offset center = Offset(size.width / 1.5, size.height / 3);

    canvas.drawCircle(center, 100, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Bottom Left Circle
class CirclePainterBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Color(0xFFFFB33B);

    Offset center = Offset(size.width / 3, size.height / 1.5);

    canvas.drawCircle(center, 100, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
