import 'package:feelps/app/core/enum/motorcycle_colors_enum.dart';

class RegisterMotorcycleRequest {
  final String brand;
  final String model;
  final int year;
  final String photoUrl;
  final MotorcycleColorsEnum color;
  final String plate;

  RegisterMotorcycleRequest(
      {required this.brand,
      required this.model,
      required this.year,
      required this.photoUrl,
      required this.color,
      required this.plate});

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'model': model,
      'year': year,
      'photoUrl': photoUrl,
      'color': color.getString(),
      'plate': plate,
    };
  }

  factory RegisterMotorcycleRequest.fromMap(Map<String, dynamic> map) {
    return RegisterMotorcycleRequest(
      brand: map['brand'] as String,
      model: map['model'] as String,
      year: map['year'] as int,
      photoUrl: map['photoUrl'] as String,
      color: MotorcycleColorsExt.getByString(map['color'] as String),
      plate: map['plate'] as String,
    );
  }
}
