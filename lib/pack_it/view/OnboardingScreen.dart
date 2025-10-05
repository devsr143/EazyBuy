import 'package:flutter/material.dart';
import 'package:pack_bags/application/auth/view/Login.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/onbodyimage/Define Your Style.png',
    },
    {
      'image': 'assets/onbodyimage/Show who you are.png',
    },
  ];
  Future<void> _finishOnboarding() async {
    final box = await Hive.openBox('app');
    await box.put('isFirstTime', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_pages[index]['image']!),
                    // fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: _currentPage == index ? 20 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.white : Colors.white54,
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 30,
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                if (_currentPage == _pages.length - 1) {
                  _finishOnboarding();
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Icon(
                _currentPage == _pages.length - 1
                    ? Icons.check
                    : Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
