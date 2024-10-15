// lib/views/introduction_screen.dart

import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class IntroItem {
  final String title;
  final String description;
  final String imagePath;

  IntroItem({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final List<IntroItem> _introItems = [
    IntroItem(
      title: "Manage Your Products",
      description:
      "Effortlessly add, edit, and organize your products, ensuring your store’s catalog is always up-to-date and easy to navigate.",
      imagePath: 'assets/pic1.png',
    ),
    IntroItem(
      title: "Manage Your Stock Inventory",
      description:
      "Stay on top of your inventory with real-time updates, ensuring that your stock levels are accurate and well-managed.",
      imagePath: 'assets/pic2.png',
    ),
    IntroItem(
      title: "Streamline Your Billing Process",
      description:
      "Simplify billing with automatic tax calculations, discount application, and a seamless checkout experience.",
      imagePath: 'assets/pic3.png',
    ),
  ];

  int _currentPage = 0;
  final PageController _pageController = PageController();

  void _nextPage() {
    if (_currentPage < _introItems.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _introItems.length,
            (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          height: 5,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.5),
            color: index <= _currentPage ? Colors.blue : Colors.grey[300],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // Ensures content is within safe areas
        child: Container(
          color: Colors.white, // Changed background color to white
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: _introItems.length,
                      itemBuilder: (context, index) {
                        final item = _introItems[index];
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16),
                                Container(
                                  width: 300,
                                  child: Text(
                                    item.description,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 20),
                                _buildProgressIndicator(),
                                SizedBox(height: 50),
                                Image.asset(
                                  item.imagePath,
                                  width: 150,
                                  height: 150,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white, // Background color for the button area is also white
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentPage > 0)
                          Padding( // Added padding to shift the "Previous" button to the right
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue[900],
                                foregroundColor: Colors.white, // Text color
                              ),
                              onPressed: _previousPage,
                              child: Text(
                                "Previous",
                              ),
                            ),
                          ),
                        if (_currentPage == 0)
                          Expanded(
                            child: Container(), // Empty container for spacing
                          ),
                        if (_currentPage == 0)
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue[900],
                                foregroundColor: Colors.white,
                              ),
                              onPressed: _nextPage,
                              child: Text(
                                "Next",
                              ),
                            ),
                          ),
                        if (_currentPage == 1)
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue[900],
                                foregroundColor: Colors.white,
                              ),
                              onPressed: _nextPage,
                              child: Text(
                                "Next",
                              ),
                            ),
                          ),
                        if (_currentPage == 2)
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue[900],
                                foregroundColor: Colors.white, // Text color
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => DashboardScreen()),
                                );
                              },
                              child: Text(
                                "Finish",
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Positioned(
                top: 40,
                right: 20,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    minimumSize: Size(80, 40),
                  ), // <-- Added closing parenthesis here
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => DashboardScreen()),
                    );
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(fontSize: 16),
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
