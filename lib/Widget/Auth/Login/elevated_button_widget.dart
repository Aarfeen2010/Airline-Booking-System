import 'package:flutter/material.dart';
import 'package:travelex/colors.dart';

class ElevatedButtonWidget extends StatefulWidget {
  Color? color;
  final String buttonText;
  final String snackbarText;
  final void Function()? onPressed;

  ElevatedButtonWidget({
    required this.buttonText,
    required this.snackbarText,
    this.onPressed,
  });

  @override
  State<ElevatedButtonWidget> createState() => _ElevatedButtonWidgetState();
}

class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          widget.color = AppColors.primary;
        });
      },
      onExit: (event) {
        setState(() {
          widget.color = AppColors.secondary;
        });
      },
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color ?? AppColors.secondary,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.buttonText,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
