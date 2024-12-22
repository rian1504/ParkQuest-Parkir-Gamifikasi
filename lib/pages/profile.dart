import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkquest_parkir_gamifikasi/constants.dart';
import 'package:parkquest_parkir_gamifikasi/widgets/navigation_bar.dart';
import 'package:parkquest_parkir_gamifikasi/controllers/authentication_controller.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Data user
  final AuthenticationController _authenticationcontroller =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Profil',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFFEC827),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Akun Saya',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Profile Card
                Container(
                  width: double.infinity,
                  height: 110,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Obx(() {
                    final user = _authenticationcontroller.user.value!;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 32,
                          child: user.avatar == null
                              ? Icon(
                                  Icons.person,
                                  color: Colors.black,
                                )
                              : Image.network(storageUrl + user.avatar),
                        ),
                        SizedBox(width: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo, ${user.name}',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.username,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
          // Ubah Profil
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'Ubah Profil',
              style: GoogleFonts.inter(
                fontSize: 14,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/ubah_profile',
              );
            },
          ),
          Divider(),
          // Ubah Kata Sandi
          ListTile(
            leading: Icon(Icons.lock),
            title: Text(
              'Ubah Kata Sandi',
              style: GoogleFonts.inter(
                fontSize: 14,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/ubah_password',
              );
            },
          ),
          Divider(),
          // Ubah Kata Sandi
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text(
              'Inventory',
              style: GoogleFonts.inter(
                fontSize: 14,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/inventory',
              );
            },
          ),
          Spacer(),
          // Logout Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 64, vertical: 32),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showConfirmationDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF71010),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text(
                  'Logout',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 3),
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
                    await _authenticationcontroller.logout();
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
}
