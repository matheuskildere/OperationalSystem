import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MotorcycleEntity extends Equatable {
  final String brand;
  final String model;
  final int year;
  final String photoUrl;
  final MotorciclyColorEntity color;
  final String plate;

  const MotorcycleEntity(
      {required this.brand,
      required this.model,
      required this.year,
      required this.photoUrl,
      required this.color,
      required this.plate});

  @override
  List<Object?> get props => [brand, model, year, photoUrl, color, plate];
}

class MotorciclyColorEntity {
  final String name;
  final String color;
  MotorciclyColorEntity({
    required this.name,
    required this.color,
  });

  Color getColor() {
    final hexColor = int.parse(color.replaceAll('#', '0xFF'));
    return Color(hexColor);
  }

  String getCor() {
    return name;
  }
}
