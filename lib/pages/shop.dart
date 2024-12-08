import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'detail_avatar.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

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
            "Shop",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Category Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCategoryItem(
                      context,
                      'assets/img/basic_avatar.png',
                      'Basic',
                    ),
                    _buildCategoryItem(
                      context,
                      'assets/img/rare_avatar.png',
                      'Rare',
                    ),
                    _buildCategoryItem(
                      context,
                      'assets/img/legendary_avatar.png',
                      'Legendary',
                    ),
                  ],
                ),
              ),
              // Shop Cards
              _buildShopCard(
                context,
                'assets/img/basic_avatar.png',
                'Old Car',
                'assets/img/money.png',
                const Color(0xFFD9D9D9),
              ), // Basic
              _buildShopCard(
                context,
                'assets/img/rare_avatar.png',
                'Blue Sedan',
                'assets/img/money.png',
                const Color(0xFF176CC7),
              ), // Rare
              _buildShopCard(
                context,
                'assets/img/rare_bike_avatar.png',
                'Army Bike',
                'assets/img/money.png',
                const Color(0xFF176CC7),
              ), // Rare
              _buildShopCard(
                context,
                'assets/img/legendary_avatar.png',
                'White Sport',
                'assets/img/money.png',
                const Color(0xFFF71010),
              ), // Legendary
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  // Category Item
  Widget _buildCategoryItem(
      BuildContext context, String imagePath, String title) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  // Shop Card
  Widget _buildShopCard(BuildContext context, String imagePath, String title,
      String descriptionImagePath, Color backgroundColor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailAvatar(imagePath: imagePath, title: title),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 55.0),
        child: Container(
          width: 320,
          height: 95,
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 10,
                top: -30,
                child: Image.asset(
                  imagePath,
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 100,
                top: -5,
                right: 0,
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Column(
                      children: [
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
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
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              descriptionImagePath,
                              width: 50,
                              height: 25,
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
