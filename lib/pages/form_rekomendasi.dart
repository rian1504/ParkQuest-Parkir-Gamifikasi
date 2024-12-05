import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class FormRekomendasi extends StatefulWidget {
  const FormRekomendasi({super.key});

  @override
  State<FormRekomendasi> createState() => _FormRekomendasiState();
}

class _FormRekomendasiState extends State<FormRekomendasi> {
  File? _image;
  String? _imageName;

  // Image Picker
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _imageName = pickedImage.name;
      });
    }
  }

  // Image Picker Options
  void _showPickerOptions() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pilih Gambar Dari',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.photo_fill_on_rectangle_fill),
                  title: Text("Galeri"),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.photo_camera_solid),
                  title: Text("Kamera"),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Form Label
  Widget _buildFormLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Success Dialog
  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(20),
          content: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/img/success_clap.png',
                      width: 200,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Yeayyy!!! Kamu berhasil mendapatkan 10 exp',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            CupertinoIcons.chevron_left,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                // Field Kapasitas
                _buildFormLabel("Kapasitas"),
                SizedBox(height: 5),
                SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Field Upload Gambar
                _buildFormLabel("Upload Gambar"),
                SizedBox(height: 5),
                SizedBox(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.end,
                    onTap: _showPickerOptions,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      prefixIcon: IconButton(
                        onPressed: () {
                          _showPickerOptions();
                        },
                        icon: Icon(CupertinoIcons.arrow_up_doc),
                      ),
                      hintText: _imageName,
                      hintStyle: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),
                // Gambar
                SizedBox(
                  child: _image != null
                      ? Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Image.file(_image!, fit: BoxFit.cover),
                        )
                      : SizedBox.shrink(),
                ),
                SizedBox(height: 20),
                // Field Catatan
                _buildFormLabel("Catatan"),
                SizedBox(height: 5),
                SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                // Submit Button
                SizedBox(
                  width: 148,
                  child: TextButton(
                    onPressed: () {
                      _showAlertDialog();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFFEC827),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
