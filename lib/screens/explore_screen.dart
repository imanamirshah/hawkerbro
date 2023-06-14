import 'package:flutter/material.dart';
import 'package:hawkerbro/provider/auth_provider.dart';
import 'package:hawkerbro/screens/account_screen.dart';
import 'package:hawkerbro/screens/hawker_screen.dart';
import 'package:hawkerbro/screens/search_screen.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  PageController pageController = PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        titleSpacing: 8,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, ${ap.userModel.name} ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Find Delicious Hawker Food',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contex) => const AccountScreen(),
                  ),
                );
              },
              icon: CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(ap.userModel.profilePic),
                radius: 50,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (contex) => const SearchPage(),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 10),
                      Text('Search...'),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildContainer('Widget 1', 'Recommendations'),
                        const SizedBox(width: 16),
                        _buildContainer('Widget 2', 'For You'),
                        const SizedBox(width: 16),
                        _buildContainer('Widget 3', 'Trending'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Near You',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 220,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HawkerStallScreen(
                              stallName: 'Stall name',
                              stallAddress: 'Stall address',
                              stallDescription: 'Stall description',
                            ),
                          ),
                        );
                      },
                      child: PageView.builder(
                        itemCount:
                            2, // Update the item count to 2 for 2 hawker stalls
                        itemBuilder: (context, position) {
                          if (position == 0) {
                            return _buildPageItem(
                              'assets/laksa.jpeg', // Provide the image path for Old Nonya
                              'Old Nonya',
                              '5.0',
                              '369',
                            );
                          } else {
                            return _buildPageItem(
                              'assets/tiantian.jpeg',
                              'Tian Tian Hainanese Chicken Rice',
                              '5.0',
                              '1234',
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(String text, String label) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Handle container tap
          },
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(
      String imagePath, String title, String stars, String reviews) {
    return Stack(
      children: [
        Container(
          height: 250,
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFF69c5df),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(imagePath),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100,
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(stars),
                      const SizedBox(width: 10),
                      Text(reviews +
                          ' reviews'), // Add ' reviews' after the number of reviews
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
