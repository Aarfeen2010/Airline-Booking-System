import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travelex/Auth/signup_page.dart';
import 'package:travelex/Widget/Auth/Onboarding/onboarding_slide.dart';
import 'package:travelex/Widget/Auth/Onboarding/service_card.dart';
import 'package:travelex/Widget/Auth/Onboarding/social_media_icon.dart';
import 'dart:async';

import 'package:travelex/Widget/Text/poppins.dart';
import 'package:travelex/Widget/Text/roboto.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

final List<ServicesCard> _cards = [
  ServicesCard(
    image: "assets/images/lunch.jpg",
    title: "Lunch Break",
    description:
        "Experience a satisfying in-flight lunch service, crafted for comfort and taste during your journey.",
  ),
  ServicesCard(
    image: "assets/images/wifi.jpg",
    title: "Wifi and entertainment",
    description:
        "Stay connected throughout your journey with fast and reliable in-flight Wi-Fi, allowing you to browse, chat, or work seamlessly above the clouds.",
  ),
  ServicesCard(
    image: "assets/images/baggage.jpg",
    title: "Baggage Transportation",
    description:
        "Travel stress-free with our secure baggage transportation service, ensuring your luggage is safely handled from check-in to your final destination.",
  ),
  ServicesCard(
    image: "assets/images/travel_info.jpg",
    title: "Travel Information",
    description:
        "Access essential travel information at your fingertips, including flight details, airport guides, visa requirements, and more to make your journey smooth and worry-free.",
  ),
  ServicesCard(
    image: "assets/images/seat.jpg",
    title: "Seat Selection",
    description:
        "Choose your preferred seat in advance and enjoy the comfort and convenience of traveling exactly the way you like.",
  ),
  ServicesCard(
    image: "assets/images/payment.jpg",
    title: "Easy Payments",
    description:
        "Book flights securely with multiple payment options, offering a smooth and flexible checkout process.",
  ),
];

final List<OnboardingSlide> _slides = [
  OnboardingSlide(
    image: 'assets/images/flight1.jpg',
    text: "Book Flights\n With Ease",
    textColor: Color(0xff3d495d),
  ),
  OnboardingSlide(
    image: "assets/images/flight2.jpg",
    text: "Track Your \n     Flights",
    textColor: Color(0xff3d495d),
  ),
  OnboardingSlide(
    image: "assets/images/flight_3.jpg",
    text: "Enjoy hassle-free\n journeys",
    textColor: Color(0xff3d495d),
  ),
];

PageController pageController = PageController();
int _currentPage = 0;
final int _numPages = _slides.length;

class _OnboardingScreenState extends State<OnboardingScreen> {
  Color? color;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _numPages) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      pageController.animateToPage(
        _currentPage,

        duration: Duration(seconds: 3),
        curve: Curves.easeInOut,
      );
    });
    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() => _currentPage = page);
      }
    });
  }

  _OnboardingScreenState();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount;
    double childAspectRatio;
    if (width >= 1500) {
      crossAxisCount = 3;
      childAspectRatio = 4 / 5;
    } else if (width >= 700) {
      crossAxisCount = 2;
      childAspectRatio = 3 / 4;
    } else {
      crossAxisCount = 1;
      childAspectRatio = 1.5 / 1; // more horizontal for small screens
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50.h,
              constraints: BoxConstraints(minHeight: 200, maxHeight: 400),
              child: PageView(controller: pageController, children: _slides),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_numPages, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: _currentPage == index ? 12 : 8,
                        height: _currentPage == index ? 12 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _currentPage == index
                                  ? Colors.blueAccent
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Poppins(
                  text: "Our Services",

                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff4FC3F7),
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.all(2.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 2.w,
                  mainAxisSpacing: 2.h,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: _cards.length,
                itemBuilder: (context, index) => _cards[index],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialMediaIcon(
                    icon: FontAwesomeIcons.squareXTwitter,
                    newColor: Colors.black,
                  ),
                  SocialMediaIcon(icon: FontAwesomeIcons.twitter),
                  SocialMediaIcon(
                    newColor: const Color.fromARGB(255, 2, 65, 173),

                    icon: FontAwesomeIcons.linkedin,
                  ),
                  SocialMediaIcon(
                    newColor: Colors.deepPurple,
                    icon: FontAwesomeIcons.instagram,
                  ),
                  SocialMediaIcon(
                    icon: FontAwesomeIcons.youtube,
                    newColor: Colors.red,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            MouseRegion(
              onHover: (event) {
                setState(() {
                  color = Color(0xff4FC3F7);
                });
              },
              onExit: (event) {
                setState(() {
                  color = Color(0xffFF7043);
                });
              },
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    color ?? Color(0xffFF7043),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: SignUpPage(),
                    ),
                  );
                },
                child: Poppins(
                  text: "Sign Up",
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
