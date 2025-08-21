import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travelex/Widget/Text/poppins.dart';
import 'package:travelex/Widget/Text/roboto.dart';

class ServicesCard extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  Color? color;

  ServicesCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.color,
  });

  @override
  State<ServicesCard> createState() => _ServicesCardState();
}

class _ServicesCardState extends State<ServicesCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardHeight = constraints.maxHeight;
        if (cardHeight > 200) cardHeight = 200;

        double cardWidth = constraints.maxWidth;

        // Image height proportional but capped
        double imageHeight = cardWidth * 0.35;
        if (imageHeight > 200) imageHeight = 200;

        // Font sizes scale with card width
        double titleFontSize = cardWidth * 0.07; // 7% of card width
        double descFontSize = cardWidth * 0.05; // 5% of card width

        // Cap the font sizes to avoid being too big
        if (titleFontSize > 20) titleFontSize = 20;
        if (descFontSize > 16) descFontSize = 16;

        return MouseRegion(
          onHover: (event) {
            setState(() {
              widget.color = Color(0xff4FC3F7);
            });
          },
          onExit: (event) {
            setState(() {
              widget.color = Colors.white;
            });
          },
          child: Card(
            color: widget.color,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.image,
                        height: imageHeight,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Flexible(
                    child: Align(
                      alignment: Alignment.center,
                      child: Poppins(
                        text: widget.title,
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                        maxLines: 2,
                        color: Color(0xffFF7043),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Expanded(
                    child: Roboto(
                      text: widget.description,
                      fontSize: descFontSize,
                      maxLines: 3,
                      textStyle: TextStyle(height: 1.5),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xff8BC34A),
                        ),
                      ),
                      onPressed: () {},
                      child: Roboto(
                        text: "Learn More",
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
