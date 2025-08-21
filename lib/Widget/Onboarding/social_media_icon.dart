import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SocialMediaIcon extends StatefulWidget {
  final IconData icon;
  Color? color;
  PointerHoverEventListener? onHover;
  Color? newColor;

  SocialMediaIcon({
    super.key,
    required this.icon,
    this.color,
    this.onHover,
    this.newColor,
  });

  @override
  State<SocialMediaIcon> createState() => _SocialMediaIconState();
}

class _SocialMediaIconState extends State<SocialMediaIcon> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          widget.color = widget.newColor;
        });
      },
      onExit: (event) {
        setState(() {
          widget.color = Color(0xff4FC3F7);
        });
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color ?? Color(0xff4FC3F7),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Icon(widget.icon, color: Colors.white),
        ),
      ),
    );
  }
}
