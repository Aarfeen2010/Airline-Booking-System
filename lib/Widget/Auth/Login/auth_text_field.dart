import 'package:flutter/material.dart';
import 'package:travelex/colors.dart';

class AuthTextField extends StatefulWidget {
  final TextInputType keyboardType;
  final bool obscureText;
  final String labelText;
  final Color iconColor;
  final Color? fillColor;
  final IconData icon;
  final double? borderRadius;
  final Color? textColor;
  final Color? labelColor;
  AuthTextField({
    required this.keyboardType,
    required this.obscureText,
    required this.labelText,
    required this.iconColor,
    this.fillColor,
    required this.icon,
    this.borderRadius,
    this.textColor,
    this.labelColor,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscure;

  @override
  void initState() {
    _obscure = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      style: TextStyle(color: widget.textColor ?? Colors.white),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadius ?? 5),
          ),
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(color: widget.labelColor ?? Colors.white),
        prefixIcon: Icon(widget.icon, color: widget.iconColor),
        suffixIcon:
            widget.obscureText
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                  ),
                )
                : null,

        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: widget.fillColor ?? AppColors.text.withOpacity(0.3),
        filled: true,
      ),
    );
  }
}
