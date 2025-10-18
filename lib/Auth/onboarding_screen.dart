import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelex/Auth/signup_page.dart';
import 'package:travelex/Home/home.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  bool _isLastPage = false;
  bool isLoading = false;

  final List<Map<String, String>> _slides = [
    {
      "icon": "✈️",
      "title": "Discover The World",
      "subtitle": "Book flights with ease and explore new destinations with Travelex.",
    },
    {
      "icon": "🌍",
      "title": "Smart & Simple Booking",
      "subtitle": "Plan your journey with smart search, best deals, and fast checkout.",
    },
    {
      "icon": "🧳",
      "title": "Your Travel Companion",
      "subtitle": "Track bookings, get instant updates, and manage your trips effortlessly.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _autoSlide();
  }

  void _autoSlide() async {
    // Automatically move pages every 3 seconds until the last page
    while (mounted) {
      await Future.delayed(const Duration(seconds: 3));
      if (_currentPage < _slides.length - 1) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      } else {
        setState(() => _isLastPage = true);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    _isLastPage = index == _slides.length - 1;
                  });
                },
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedScale(
                          scale: 1.0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutBack,
                          child: Text(slide["icon"]!,
                              style: const TextStyle(fontSize: 90)),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          slide["title"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          slide["subtitle"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slides.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                  height: 10,
                  width: _currentPage == index ? 24 : 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.indigo
                        : Colors.red.shade300.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: ()async  {
                      setState(() {
                        isLoading = true;
                      });
                      await Future.delayed(Duration(seconds: 2));
                      // Navigate to home or signup
                      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: SignUpPage()));
                    },
                    child: isLoading ? SizedBox(
                      width: 26,
                      height: 26,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                        
                      
                      ),
                    ) : 
                     Text(
                      "Get Started",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
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
}
