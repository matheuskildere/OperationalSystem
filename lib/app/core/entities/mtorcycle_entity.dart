import 'package:equatable/equatable.dart';
import 'package:feelps/app/core/enum/motorcycle_colors_enum.dart';

class MotorcycleEntity extends Equatable {
  final String brand;
  final String model;
  final String year;
  final String photoBase64;
  final MotorcycleColorsEnum color;
  final String plate;

  const MotorcycleEntity(this.brand, this.model, this.year, this.photoBase64,
      this.color, this.plate);

  @override
  List<Object?> get props => [brand, model, year, photoBase64, color, plate];
}
