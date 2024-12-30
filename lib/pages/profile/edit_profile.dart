import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/profile_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // Profile
  final ProfileController _profilecontroller = Get.put(ProfileController());

  final _name = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _identityNumber = TextEditingController();
  final _company = TextEditingController();
  final _position = TextEditingController();

  @override
  initState() {
    super.initState();
    _profilecontroller.profile();
  }

  // Text Form Field
  Widget _buildTextFormField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: TextFormField(
          controller: controller,
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
                    await _profilecontroller.ubahProfile(
                      name: _name.text.trim(),
                      username: _username.text.trim(),
                      email: _email.text.trim(),
                      identityNumber: _identityNumber.text.trim(),
                      company: _company.text.trim(),
                      position: _position.text.trim(),
                      onSuccess: () {
                        _showSuccessDialog();
                        _profilecontroller.profile();
                      },
                    );
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
                        'Data Berhasil Diperbarui!',
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
          'Ubah Profil',
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
                height: 650,
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

                        if (_name.text.isEmpty) {
                          _name.text = user.name;
                          _username.text = user.username;
                          _email.text = user.email;
                          _identityNumber.text = user.identityNumber;
                          _company.text = user.eksternal?.agencyCompany ?? '';
                          _position.text = user.eksternal?.position ?? '';
                        }

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
                            // Text Form Field
                            _buildTextFormField('Nama Lengkap', _name),
                            _buildTextFormField('Username', _username),
                            _buildTextFormField('Email', _email),
                            _buildTextFormField('NIM', _identityNumber),
                            if (user.eksternal != null)
                              _buildTextFormField('Instansi', _company),
                            if (user.eksternal != null)
                              _buildTextFormField('Jabatan', _position),
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
