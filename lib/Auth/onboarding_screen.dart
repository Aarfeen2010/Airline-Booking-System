import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:async';

import 'package:travelex/Widget/poppins.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

PageController pageController = PageController();
int _currentPage = 0;
final int _numPages = 3;

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _numPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 200,
        child: PageView(
          controller: pageController,

          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Poppins(text: "Book Flights With Ease", fontSize: 16.sp),
                      Poppins(
                        text: "Your Simple Guide to Stress-Free Air Travel",
                        fontSize: 14.sp,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 200,

                          child: Image.network(
                            "https://www.istockphoto.com/photo/life-work-balance-and-city-living-lifestyle-concept-of-business-man-relaxing-take-it-gm1183657530-332883996?searchscope=image%2Cfilm",
                          ),
                        ),
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
}
