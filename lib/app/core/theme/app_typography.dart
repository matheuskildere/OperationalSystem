import 'package:flutter/material.dart';

class AppTypography {
  static TextTheme textTheme = TextTheme(
      headline1: h1,
      headline2: h2,
      bodyText1: bodyText,
      bodyText2: labelText,
      caption: hintText,
      button: buttonText);

  static TextStyle h1 = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );

  static TextStyle h2 = const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w300,
  );

  static TextStyle bodyText = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w300,
  );

  static TextStyle labelText = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static TextStyle buttonText = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static TextStyle hintText = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
}

extension StringExt on String {
  String trim() {
    return replaceAll(' ', '');
  }
}

extension MoneyToDouble on String {
  double moneyToDouble() {
    return double.parse(replaceAll('.', '').replaceAll(',', '.'));
  }
}
