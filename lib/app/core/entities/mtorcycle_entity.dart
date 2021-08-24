import 'package:equatable/equatable.dart';
import 'package:feelps/app/core/enum/motorcycle_colors_enum.dart';

class MotorcycleEntity extends Equatable {
  final String brand;
  final String model;
  final int year;
  final String photoBase64;
  final MotorcycleColorsEnum color;
  final String plate;

  const MotorcycleEntity(
      {required this.brand,
      required this.model,
      required this.year,
      required this.photoBase64,
      required this.color,
      required this.plate});

  @override
  List<Object?> get props => [brand, model, year, photoBase64, color, plate];
}
