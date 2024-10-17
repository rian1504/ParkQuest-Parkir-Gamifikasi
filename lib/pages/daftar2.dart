import 'package:flutter/material.dart';

class Daftar2 extends StatelessWidget {
  const Daftar2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Curved Yellow Background with image and text side by side
            Stack(
              children: [
                ClipPath(
                  clipper: RoundedClipper(),
                  child: Container(
                    height: MediaQuery.of(context).size.height *
                        0.45, // Covers almost half the screen
                    decoration: const BoxDecoration(
                      color: Color(0xFFFEC827), // Yellow background
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/register.png', // Replace with your image path
                            height: 150, // Increased image size
                          ),
                          const SizedBox(
                              width: 20), // Space between image and text
                          const Text(
                            'Registrasi',
                            style: TextStyle(
                              fontSize: 40, // Increased font size
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Center the registration form and move it higher
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height *
                    0.05, // Move the form higher
                left: 30,
                right: 30,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  children: [
                    // Internal and External buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/daftar');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                            ),
                            child: const Text('Internal',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFEC827),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                ),
                              ),
                            ),
                            child: const Text('Eksternal',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Form Inputs
                    _buildTextField('Nama'),
                    _buildTextField('Username'),
                    _buildTextField('No KTP/NIK'),
                    _buildTextField('Instansi/Perusahaan'),
                    _buildTextField('Jabatan'),
                    _buildTextField('Email'),
                    _buildTextField('Password', isPassword: true),
                    const SizedBox(height: 20),
                    // Submit Button
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFEC827),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 80),
                      ),
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Link for login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Sudah Punya akun?'),
                        TextButton(
                          onPressed: () {
                            // Navigate to login
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.black),
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
      ),
    );
  }

  // Function to create text fields
  Widget _buildTextField(String label, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
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

// Custom Clipper for the curved yellow background
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

void main() {
  runApp(MaterialApp(
    home: Daftar2(),
  ));
}
