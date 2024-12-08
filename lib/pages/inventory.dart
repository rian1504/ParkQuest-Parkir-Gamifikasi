import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

// Default avatar
class _InventoryState extends State<Inventory> {
  String _selectedButton = "basic";
  String _selectedAvatar = 'assets/img/basic_avatar.png';
  String _selectedAvatarName = "Old Car";

// List Categories
  final List<Category> categories = [
    Category("basic", const Color(0xFFD9D9D9), "Basic", [
      "assets/img/basic_avatar.png",
      "assets/img/basic_bike_avatar.png",
    ], [
      "Old Car",
      "Scooter",
    ]),
    Category("rare", const Color(0xFF2592E7), "Rare", [
      "assets/img/rare_avatar.png",
      "assets/img/rare_bike_avatar.png",
    ], [
      "Blue Sedan",
      "Army Bike",
    ]),
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.amber[300],
          title: const Text(
            "Inventory",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 35),
              _buildAvatarSection(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 5,
                  ),
                  backgroundColor: Colors.amber[300],
                ),
                child: const Text(
                  "Gunakan",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),
              _buildCategoryButtons(),
              const SizedBox(height: 16),
              // Divider 1
              const Divider(
                thickness: 1,
                color: Colors.black,
                height: 25,
              ),
              _buildSelectedCategoryLabel(),
              // Divider 2
              const Divider(
                thickness: 1,
                color: Colors.black,
                height: 0,
              ),
              Container(
                color: const Color(0xFFFFD05E),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: _buildItemGrid(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Button Categories
  Widget _buildAvatarSection() {
    return Column(
      children: [
        const Text(
          "Avatar",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Image.asset(
          _selectedAvatar,
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 12),
        Text(
          _selectedAvatarName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final category in categories)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: _buildCategoryButton(
                category.name, category.color, category.label),
          ),
      ],
    );
  }

  Widget _buildCategoryButton(String category, Color color, String label) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedButton = category;
        });
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        side: const BorderSide(color: Colors.black),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedCategoryLabel() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: const Text(
              "My Avatars",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              bottom: 10.0,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 20.0,
              ),
              decoration: BoxDecoration(
                color: categories
                    .firstWhere((c) => c.name == _selectedButton)
                    .color,
                borderRadius: BorderRadius.circular(60.0),
              ),
              child: Text(
                _selectedButton.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemGrid() {
    final category = categories.firstWhere((c) => c.name == _selectedButton);

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.8,
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
              Card(
                elevation: 4,
                color: category.color,
                margin: const EdgeInsets.only(top: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
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
              Positioned(
                left: 2,
                top: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 120,
                    height: 160,
                    child: Image.asset(
                      category.assets[index],
                      fit: BoxFit.contain,
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
