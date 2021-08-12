import 'package:flutter/material.dart';

enum MotorcycleColorsEnum {
  red,
  grey,
  blue,
  black,
}

extension MotorcycleColorsExt on MotorcycleColorsEnum {
  Color get getColor {
    switch (this) {
      case MotorcycleColorsEnum.red:
        return Color(0xFFB00020);
      case MotorcycleColorsEnum.blue:
        return Color(0xFF37ABFF);
      case MotorcycleColorsEnum.grey:
        return Color(0xFFD4D4D4);
      case MotorcycleColorsEnum.black:
        return Color(0xFF090909);
      default:
        return Color(0xFF090909);
    }
  }

  static MotorcycleColorsEnum getByString(String group) {
    switch (group) {
      case "red":
        return MotorcycleColorsEnum.red;
      case "blue":
        return MotorcycleColorsEnum.blue;
      case "black":
        return MotorcycleColorsEnum.black;
      case "grey":
        return MotorcycleColorsEnum.grey;
      default:
        return MotorcycleColorsEnum.black;
    }
  }

  String getString() {
    switch (this) {
      case MotorcycleColorsEnum.red:
        return "red";
      case MotorcycleColorsEnum.blue:
        return "blue";
      case MotorcycleColorsEnum.black:
        return "black";
      case MotorcycleColorsEnum.grey:
        return "grey";
      default:
        return "black";
    }
  }

  String getCor() {
    switch (this) {
      case MotorcycleColorsEnum.red:
        return "Vermelho";
      case MotorcycleColorsEnum.blue:
        return "Azul";
      case MotorcycleColorsEnum.black:
        return "Preto";
      case MotorcycleColorsEnum.grey:
        return "Cinza";
      default:
        return "Preto";
    }
  }
}
