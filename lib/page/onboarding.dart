import 'package:dictionaryenkh/controller/auth_controller.dart';
import 'package:dictionaryenkh/page/login.dart';
import 'package:flutter/material.dart';
import 'package:dictionaryenkh/utils/app_textstyles.dart';
import 'package:get/get.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<OnboardingItem> _items = [
    OnboardingItem(
      description:
          'Believe in your potential and imagine goals that go beyond your current limits',
      image: 'assets/images/intro1.jpg',
      title: 'Dream Big',
    ),
    OnboardingItem(
      description:
          'Focus, practice, and give your best effort to learn and improve every day',
      image: 'assets/images/intro2.jpg',
      title: 'Study Hard',
    ),
    OnboardingItem(
      description:
          'Use your skills and confidence to stand out and inspire others with your success.',
      image: 'assets/images/intro3.jpg',
      title: 'Shine Bright',
    ),
  ];

  void _handleGetStarted() {
    final AuthController authController = AuthController();
    authController.setFirstTimeDone();
    Get.off(Login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _items[index].image,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),

                  SizedBox(height: 40),

                  Text(
                    _items[index].title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.withColor(
                      AppTextStyle.h2,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),

                  SizedBox(height: 16),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      _items[index].description,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.withColor(
                        AppTextStyle.bodyLarge,
                        // Theme.of(context).textTheme.bodyMedium!.color!,
                        Colors.grey,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                (index) => AnimatedContainer(
                  duration: Duration(microseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 4,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 18, 62, 95),

                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _handleGetStarted();
                  },
                  child: Text(
                    "Skip",
                    style: AppTextStyle.withColor(
                      AppTextStyle.buttonMedium,
                      Color.fromARGB(255, 18, 62, 95),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _items.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _handleGetStarted();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 18, 62, 95),
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: Text(
                    _currentPage < _items.length - 1 ? 'Next' : 'Get Started',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.description,
    required this.image,
    required this.title,
  });
}
