import 'package:flutter/material.dart';

class OnboardingSlide extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? subtitle;

  OnboardingSlide({ required this.icon, required this.title, required this.subtitle});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Emoji icon
          AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutBack,
            child: Text(
              icon ?? "T",
              style: const TextStyle(fontSize: 90),
            ),
          ),
          const SizedBox(height: 30),

          // Title
          Text(
            title ?? "Travelex",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),

          const SizedBox(height: 16),

          // Subtitle
          Text(
            subtitle ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}