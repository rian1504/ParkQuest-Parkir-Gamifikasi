import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final String _selectedButton = "basic";
  String _selectedAvatar = 'assets/img/basic_avatar.png';
  String _selectedAvatarName = "Old Car";
  var selectedCategory = "Basic";

  // Categories
  final List<Category> categories = [
    // Basic Category
    Category("basic", const Color(0xFFD9D9D9), "Basic", [
      "assets/img/basic_avatar.png",
      "assets/img/basic_bike_avatar.png",
    ], [
      "Old Car",
      "Scooter",
    ]),
    // Rare Category
    Category("rare", const Color(0xFF2592E7), "Rare", [
      "assets/img/rare_avatar.png",
      "assets/img/rare_bike_avatar.png",
    ], [
      "Blue Sedan",
      "Army Bike",
    ]),
    // Legendary Category
    Category("legendary", const Color(0xFFF71010), "Legendary", [
      "assets/img/legendary_avatar.png",
      "assets/img/legendary2_avatar.png",
    ], [
      "White Sport",
      "White Jeep",
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC827),
        title: Text(
          'Inventory',
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
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            _buildAvatarSection(),
            // Category
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryButton(
                    'Basic',
                    "Basic",
                    Color(0xFFD9D9D9),
                    Color(0xFF545454),
                  ),
                  _buildCategoryButton(
                    'Rare',
                    "Rare",
                    Color(0xFF5EB8FF),
                    Color(0xFF003966),
                  ),
                  _buildCategoryButton(
                    'Legendary',
                    "Legendary",
                    Color(0xFFFF2323),
                    Color(0xFF5D0000),
                  ),
                ],
              ),
            ),
            // My Avatar
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 12,
                  left: 16,
                  right: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 28),
                      child: Text(
                        'My Avatar',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: _buildItemGrid(),
                      ),
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

  // Avatar
  Widget _buildAvatarSection() {
    return Column(
      children: [
        Text(
          "Avatar",
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
            _selectedAvatar,
            fit: BoxFit.contain,
          ),
        ),
        Text(
          _selectedAvatarName,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: 160,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFFFECE2E),
            ),
            child: Text(
              'Gunakan',
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
  }

  // Category Button
  Widget _buildCategoryButton(
    String text,
    String role,
    Color backgroundColor,
    Color textColor,
  ) {
    return SizedBox(
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedCategory = role;
          });
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24),
          backgroundColor:
              selectedCategory == role ? backgroundColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            side: selectedCategory == role
                ? BorderSide.none
                : BorderSide(color: Colors.black),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: selectedCategory == role ? textColor : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildItemGrid() {
    final category = categories.firstWhere((c) => c.name == _selectedButton);

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 1.2,
      ),
      itemCount: category.assets.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedAvatar = category.assets[index];
              _selectedAvatarName = category.names[index];
            });
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Card
              Card(
                elevation: 2,
                color: category.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 16,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Avatar
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      category.assets[index],
                      fit: BoxFit.cover,
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
}

class Category {
  final String name;
  final Color color;
  final String label;
  final List<String> assets;
  final List<String> names;

  Category(
    this.name,
    this.color,
    this.label,
    this.assets,
    this.names,
  );
}
