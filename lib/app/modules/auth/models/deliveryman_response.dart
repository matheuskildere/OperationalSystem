import 'package:feelps/app/core/entities/deliveryman_entity.dart';
import 'package:feelps/app/core/entities/motorcycle_entity.dart';
import 'package:feelps/app/core/utils/data_parser.dart';
import 'package:feelps/app/modules/motorcycle/models/motorcicly_color_model.dart';

class DelvierymanResponse extends DeliverymanEntity {
  final String id;
  final String email;
  final String? password;
  final String fullName;
  final String phoneNumber;
  final DateTime birthday;
  final DateTime? createdAt;
  final String cpf;
  final String photoUrl;
  final bool status;
  final bool isAvaliable;
  final MotorcycleModel? motocycle;

  const DelvierymanResponse({
    required this.id,
    required this.email,
    this.password,
    this.createdAt,
    required this.fullName,
    required this.phoneNumber,
    required this.birthday,
    required this.cpf,
    required this.photoUrl,
    required this.status,
    required this.isAvaliable,
    this.motocycle,
  }) : super(
          id: id,
          birthday: birthday,
          cpf: cpf,
          email: email,
          fullName: fullName,
          password: password,
          createdAt: createdAt,
          phoneNumber: phoneNumber,
          photoUrl: photoUrl,
          status: status,
          isAvaliable: isAvaliable,
          motorcycle: motocycle,
        );

  factory DelvierymanResponse.fromMap(Map<String, dynamic> map) {
    return DelvierymanResponse(
      id: map['id'].toString(),
      email: map['email'].toString(),
      fullName: map['fullName'].toString(),
      phoneNumber: map['phoneNumber'].toString(),
      birthday: DateParser.getDateTime(map['birthday'].toString()),
      createdAt: DateParser.getDateTime(map['createdAt'].toString()),
      cpf: map['cpf'].toString(),
      photoUrl: map['photoUrl'].toString(),
      status: map['status'] as bool,
      isAvaliable: map['isAvaliable'] as bool,
      motocycle: map['motorcycle'] != null
          ? MotorcycleModel.fromMap(
              Map<String, dynamic>.from(map['motorcycle'] as Map))
          : null,
    );
  }
}

class MotorcycleModel extends MotorcycleEntity {
  final String brand;
  final String model;
  final int year;
  final String photoUrl;
  final MotorciclyColorModel color;
  final String plate;

  const MotorcycleModel(
      {required this.brand,
      required this.model,
      required this.year,
      required this.photoUrl,
      required this.color,
      required this.plate})
      : super(
          brand: brand,
          model: model,
          year: year,
          photoUrl: photoUrl,
          color: color,
          plate: plate,
        );

  factory MotorcycleModel.fromMap(Map<String, dynamic> map) {
    return MotorcycleModel(
      brand: map['brand'] as String,
      model: map['model'] as String,
      year: map['year'] as int,
      photoUrl: map['photoUrl'] as String,
      color: MotorciclyColorModel.fromMap(
          Map<String, dynamic>.from(map['color'] as Map)),
      plate: map['plate'] as String,
    );
  }
}
