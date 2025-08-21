import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travelex/Widget/Text/poppins.dart';

class OnboardingSlide extends StatelessWidget {
  final String image;
  final String text;
  final Color textColor;

  OnboardingSlide({
    required this.image,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 50.h,
            constraints: BoxConstraints(minHeight: 150, maxHeight: 300),

            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.h),
        Expanded(
          child: Poppins(
            text: text,
            color: textColor,
            fontSize: 23.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
