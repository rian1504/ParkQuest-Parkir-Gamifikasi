import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Section with Hello and Coin
          Container(
            color: const Color(0xFFFEC827),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ParkQuest',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        // Handle menu action
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    // Profile Picture and Details
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          "assets/img/profile.png"), // Placeholder image path
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Hello, Elys!",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("@elysaulia20"),
                        Text("100 EXP", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Spacer(),
                    // Coin Info
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.attach_money, color: Colors.yellow),
                          SizedBox(width: 5),
                          Text('5 Coin',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Main Content: Search and Recommendations
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFeatureCard(Icons.search, 'Cari Parkir', 0xFFFEC827),
                _buildFeatureCard(
                    Icons.star, 'Rekomendasi Tempat Parkir', 0xFFFEC827),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Features Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 69,
              runSpacing: 20,
              children: [
                InkWell(
                  onTap: () {
                    // Survey
                    Navigator.pushNamed(context, '/survey');
                  },
                  child: Column(
                    children: [
                      _buildCircularIconButton(Icons.assignment, 'Survey'),
                      const Text('Go to Survey',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Shop
                    Navigator.pushNamed(context, '/shop');
                  },
                  child: Column(
                    children: [
                      _buildCircularIconButton(Icons.shopping_cart, 'Shop'),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Inventory
                    Navigator.pushNamed(context, '/inventory');
                  },
                  child: Column(
                    children: [
                      _buildCircularIconButton(Icons.storage, 'inventory'),
                    ],
                  ),
                ),
                _buildCircularIconButton(Icons.gamepad, 'Misi'),
                _buildCircularIconButton(Icons.person_add, 'Kode Referral'),
                _buildCircularIconButton(Icons.leaderboard, 'Leaderboard'),
              ],
            ),
          ),

          const SizedBox(height: 20),
          // Leaderboard Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Leaderboard',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildLeaderboardEntry(
                    1, '@Jihan65', 'Mahasiswa', 'Kang Parkir'),
                _buildLeaderboardEntry(
                    2, '@Jihan65', 'Mahasiswa', 'Kang Parkir'),
                _buildLeaderboardEntry(
                    3, '@Jihan65', 'Mahasiswa', 'Kang Parkir'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFEC827),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: 2, // Example: QR is selected
        onTap: (index) {
          // Handle bottom nav tap
        },
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String label, int colorHex) {
    return Container(
      width: 160, // Increase width to provide more space
      height: 170, // Increase height if necessary
      decoration: BoxDecoration(
        color: Color(colorHex),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), // Add padding if needed
            child: Text(
              label,
              textAlign: TextAlign.center, // Ensure text is centered
              style: const TextStyle(
                fontSize: 14, // Reduce font size slightly
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIconButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, size: 30, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildLeaderboardEntry(
      int rank, String username, String role, String badge) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.yellow,
          child: Text('$rank',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        title:
            Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(role),
        trailing: Chip(label: Text(badge)),
      ),
    );
  }
}
