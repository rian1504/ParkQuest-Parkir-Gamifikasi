import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  String _selectedButton = "basic";
  String _selectedAvatar = 'assets/img/monkey.png'; // Default avatar
  String _selectedAvatarName = "Monkey"; // Default nama

  // Daftar kategori
  final List<Category> categories = [
    Category("basic", const Color(0xFFD9D9D9), "Basic", [
      "assets/img/bull.png",
      "assets/img/lizard.png",
    ], [
      "Bull",
      "Lizard",
    ]),
    Category("rare", const Color(0xFF2592E7), "Rare", [
      "assets/img/mouse.png",
      "assets/img/dragon.png",
    ], [
      "Mouse",
      "Dragon",
    ]),
    Category("legendary", const Color(0xFFF71010), "Legendary", [
      "assets/img/rabbit.png",
      "assets/img/sheep.png",
      "assets/img/mouse.png",
    ], [
      "Rabbit",
      "Sheep",
      "Mouse",
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
              // Container Avatar
              Column(
                children: [
                  // Text "Avatar"
                  const Text(
                    "Avatar",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Img Avatar
                  Image.asset(
                    _selectedAvatar,
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _selectedAvatarName, // Menampilkan nama avatar
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Rating Bar
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle Button
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  backgroundColor: Colors.amber[300],
                ),
                child: const Text(
                  "Gunakan",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),
              buildButtons(),
              const SizedBox(height: 16),
              //Divider 1
              const Divider(
                thickness: 1,
                color: Colors.black,
                height: 25,
              ),
              // Divider 2
              buildSelectedCategoryLabel(),
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

 // 3 Kategori Button
  Widget buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final category in categories)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: buildCategoryButton(
                category.name, category.color, category.label),
          ),
      ],
    );
  }

  // Inventory
  Widget buildCategoryButton(String category, Color color, String label) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedButton = category;
        });
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

  // Text and label category
  Widget buildSelectedCategoryLabel() {
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
            padding: const EdgeInsets.only(left: 15.0, bottom: 10.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
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
    //Find category from categories list
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
              // Avatar's Card
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
                      // Rating bar
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
                left: 16,
                top: 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    category.assets[index],
                    width: 80,
                    height: 120,
                    fit: BoxFit.cover,
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

// Class Kategori
class Category {
  final String name;
  final Color color;
  final String label;
  final List<String> assets;
  final List<String> names;

  Category(this.name, this.color, this.label, this.assets, this.names);
}
