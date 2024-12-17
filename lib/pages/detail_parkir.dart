import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:parkquest_parkir_gamifikasi/pages/detail_rekomendasi.dart';

class DetailParkir extends StatefulWidget {
  const DetailParkir({super.key});

  @override
  State<DetailParkir> createState() => _DetailParkirState();
}

class _DetailParkirState extends State<DetailParkir> {
  // Title Text
  Widget _buildTitleText(String text) {
    return Row(
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Text
  Widget _buildText(String text) {
    return Row(
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  // Colored Box
  Widget _buildColoredBox(Color color) {
    return SizedBox(
      width: 24,
      height: 24,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color),
      ),
    );
  }

  // Card
  Widget _buildCard(
      String image, String name, String time, String description) {
    return Material(
      child: Container(
        height: 75,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailRekomendasi(),
              ),
            );
          },
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Foto Profil
                  CircleAvatar(
                    backgroundImage: AssetImage(image),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Nama
                      Text(
                        name,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10),
                      // Waktu
                      Text(
                        time,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Catatan
                      SizedBox(
                        width: 250,
                        child: Text(
                          description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
        title: Text(
          'Gedung Utama',
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // Banner Image
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/img/gedung_utama.png',
                fit: BoxFit.cover,
              ),
            ),
            // Tab Bar
            TabBar(
              indicatorColor: Color(0xFFFEC827),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              tabs: [
                Tab(text: 'Informasi'),
                Tab(text: 'Rekomendasi'),
              ],
            ),
            // Content
            Expanded(
              child: TabBarView(
                children: [
                  // Tab Informasi
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Kapasitas Kendaraan
                        SizedBox(height: 32),
                        _buildTitleText('Kapasitas Kendaraan'),
                        SizedBox(height: 16),
                        _buildText('Motor'),
                        SizedBox(height: 8),
                        _buildText('300 Unit'),
                        // Perkiraan Ketersediaan Parkir
                        SizedBox(height: 20),
                        _buildTitleText('Perkiraan Ketersediaan Parkir'),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Column(
                              children: [
                                _buildText('07.00 - 10.00'),
                                SizedBox(height: 12),
                                _buildText('10.00 - 12.00'),
                                SizedBox(height: 12),
                                _buildText('12.00 - 13.00'),
                                SizedBox(height: 12),
                                _buildText('13.00 - 17.00'),
                              ],
                            ),
                            SizedBox(width: 24),
                            Column(
                              children: [
                                _buildColoredBox(Color(0xFF20FF0C)),
                                SizedBox(height: 12),
                                _buildColoredBox(Color(0xFFF20707)),
                                SizedBox(height: 12),
                                _buildColoredBox(Color(0xFFF8FD07)),
                                SizedBox(height: 12),
                                _buildColoredBox(Color(0xFFF20707)),
                              ],
                            ),
                          ],
                        ),
                        // Keterangan
                        SizedBox(height: 40),
                        _buildTitleText('KET'),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    _buildColoredBox(Color(0xFF20FF0C)),
                                    SizedBox(width: 12),
                                    _buildText('Sepi'),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    _buildColoredBox(Color(0xFFF8FD07)),
                                    SizedBox(width: 12),
                                    _buildText('Lumayan'),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    _buildColoredBox(Color(0xFFF20707)),
                                    SizedBox(width: 12),
                                    _buildText('Ramai'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Tab Rekomendasi
                  ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      _buildCard(
                        'assets/img/profile_picture.png',
                        'Rian',
                        '1H',
                        'Saya mendapat parkir di bawah kanopi dekat pamdal',
                      ),
                      _buildCard(
                        'assets/img/profile_picture.png',
                        'Rian',
                        '1H',
                        'Saya mendapat parkir di bawah kanopi dekat pamdal',
                      ),
                      _buildCard(
                        'assets/img/profile_picture.png',
                        'Rian',
                        '1H',
                        'Saya mendapat parkir di bawah kanopi dekat pamdal',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
