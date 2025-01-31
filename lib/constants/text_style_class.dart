// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

const String primaryFontName = 'Inter';

class TextStyleClass {
  static const double textHeight = 1.3;

  static TextStyle primaryFont300(double size, Color color) => TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w300,
      color: color,
      height: textHeight,
      fontSize: size);

  static TextStyle primaryFont400(double size, Color color) => TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w400,
      color: color,
      height: textHeight,
      fontSize: size);

  static TextStyle primaryFont500(double size, Color color) => TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w500,
      color: color,
      height: textHeight,
      fontSize: size);

  static TextStyle primaryFont600(double size, Color color) => TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w600,
      color: color,
      height: textHeight,
      fontSize: size);

  static TextStyle primaryFont700(double size, Color color) => TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w700,
      color: color,
      height: textHeight,
      fontSize: size);
}
