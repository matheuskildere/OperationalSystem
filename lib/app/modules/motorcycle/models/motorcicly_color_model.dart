import 'package:feelps/app/core/entities/motorcycle_entity.dart';

class MotorciclyColorModel extends MotorciclyColorEntity {
  final String name;
  final String color;
  MotorciclyColorModel({
    required this.name,
    required this.color,
  }) : super(
          color: color,
          name: name,
        );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color,
    };
  }

  factory MotorciclyColorModel.fromMap(Map<String, dynamic> map) {
    return MotorciclyColorModel(
      name: map['name'].toString(),
      color: map['color'].toString(),
    );
  }
}
