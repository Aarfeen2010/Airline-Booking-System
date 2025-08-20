import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Poppins extends StatelessWidget {
  final String text;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  final Color? backgroundColor;
  final Color? color;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final List<FontFeature>? fontFeatures;
  final double? fontSize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final Paint? foreground;
  final double? height;
  final double? letterSpacing;
  final List<Shadow>? shadows;
  final TextBaseline? textBaseline;
  final TextStyle? textStyle;
  final double? wordSpacing;

  Poppins({
    required this.text,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,

    this.backgroundColor,
    this.color,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.fontFeatures,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.foreground,
    this.height,
    this.letterSpacing,
    this.shadows,
    this.textBaseline,
    this.textStyle,
    this.wordSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      locale: locale,
      maxLines: maxLines,
      overflow: overflow,
      selectionColor: selectionColor,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      textWidthBasis: textWidthBasis,
      style: GoogleFonts.poppins(
        backgroundColor: backgroundColor,
        foreground: foreground,
        color: color,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFeatures: fontFeatures,
        decorationThickness: decorationThickness,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        height: height,
        letterSpacing: letterSpacing,
        locale: locale,
        shadows: shadows,
        textBaseline: textBaseline,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        background: foreground,
      ),
    );
  }
}
