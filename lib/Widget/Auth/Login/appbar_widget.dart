import 'package:flutter/material.dart';

import 'package:travelex/colors.dart';

class AppbarWidget extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final Color? bgColor;

  AppbarWidget({required this.text, this.fontWeight, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      ),
      centerTitle: true,
      backgroundColor: bgColor ?? AppColors.primary,
    );
  }
}
