import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'detail_avatar.dart';

//Shop
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
              ///Image 3 gambar
              Image.asset(
                'assets/img/shop.png',
                width: double.infinity,
                height: 150,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  //Text Kategori
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      'Basic',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Rare',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.5),
                    child: Text(
                      'Legendary',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              buildShopCard(
                  context, 'img/lizard.png', 'Lizard', 'assets/img/money.png'),
              buildShopCard(
                  context, 'img/dragon.png', 'Dragon', 'assets/img/money.png'),
              buildShopCard(
                  context, 'img/rabbit.png', 'Rabbit', 'assets/img/money.png'),
              buildShopCard(
                  context, 'img/monkey.png', 'Monkey', 'assets/img/money.png'),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

//Card Shop
  Widget buildShopCard(BuildContext context, String imagePath, String title,
      String descriptionImagePath) {
    return GestureDetector(
      //Hero untuk Detail Avatar
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
          width: 309,
          height: 88,
          decoration: BoxDecoration(
            color: const Color(0xFFFA9279),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          //Image Card
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 20,
                top: -30,
                child: Image.asset(
                  imagePath,
                  width: 80,
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
                  //Text Card
                  child: ListTile(
                    title: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    //Rating Star Card
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
