import 'package:flutter/material.dart';
import 'package:travelex/colors.dart';

class AuthTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final bool obscureText;
  final String labelText;
  final Color iconColor;
  final Color fillColor;
  final IconData icon;
  AuthTextField({
    required this.keyboardType,
    required this.obscureText,
    required this.labelText,
    required this.iconColor,
    required this.fillColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
        labelText: labelText,
        prefixIcon: Icon(icon, color: iconColor),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: fillColor,
        filled: true,
      ),
    );
  }
}
