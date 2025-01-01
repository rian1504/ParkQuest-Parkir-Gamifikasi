import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:parkquest_parkir_gamifikasi/Controllers/park_recommendation_controller.dart';

class FormRekomendasi extends StatefulWidget {
  const FormRekomendasi({super.key});

  @override
  State<FormRekomendasi> createState() => _FormRekomendasiState();
}

class _FormRekomendasiState extends State<FormRekomendasi> {
  File? _image;
  String? _imageName;

  // Park Area
  final ParkRecommendationController _parkrecommendationcontroller =
      Get.put(ParkRecommendationController());

  final _capacity = TextEditingController();
  final _description = TextEditingController();

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
                  'Pilih gambar dari',
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
  Future<void> _showSuccessDialog() async {
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
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboard');
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil arguments
    final parkAreaId = ModalRoute.of(context)!.settings.arguments as int;

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
                Obx(() {
                  return SizedBox(
                    child: TextFormField(
                      controller: _capacity,
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
                        errorText: _parkrecommendationcontroller
                                .capacityError.isNotEmpty
                            ? _parkrecommendationcontroller.capacityError.value
                            : null,
                      ),
                      onChanged: (value) {
                        _parkrecommendationcontroller.capacityError.value = '';
                      },
                    ),
                  );
                }),
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
                Container(
                  margin: EdgeInsets.only(top: 20),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: _image != null
                      ? Image.file(_image!, fit: BoxFit.cover)
                      : SizedBox.shrink(),
                ),
                SizedBox(height: 20),
                // Field Catatan
                _buildFormLabel("Catatan"),
                SizedBox(height: 5),
                Obx(() {
                  return SizedBox(
                    child: TextFormField(
                      controller: _description,
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
                        errorText: _parkrecommendationcontroller
                                .descriptionError.isNotEmpty
                            ? _parkrecommendationcontroller
                                .descriptionError.value
                            : null,
                        errorMaxLines: 2,
                      ),
                      onChanged: (value) {
                        _parkrecommendationcontroller.descriptionError.value =
                            '';
                      },
                    ),
                  );
                }),
                SizedBox(height: 50),
                // Submit Button
                SizedBox(
                  width: 148,
                  child: TextButton(
                    onPressed: () async {
                      if (_image == null) {
                        Get.snackbar(
                          'Error',
                          'Pilih gambar terlebih dahulu',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      await _parkrecommendationcontroller.storeRekomendasi(
                        parkAreaId: parkAreaId,
                        capacity: _capacity.text.trim(),
                        image: _image!.path,
                        description: _description.text.trim(),
                        onSuccess: () {
                          _showSuccessDialog();
                          _capacity.clear();
                          _description.clear();
                          _parkrecommendationcontroller.resetErrors();
                          setState(() {
                            _image = null;
                            _imageName = null;
                          });
                        },
                      );
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
