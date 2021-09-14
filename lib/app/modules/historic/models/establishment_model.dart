import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/modules/historic/models/location_model.dart';

class EstablishmentModel extends EstablishmentEntity {
  final String id;
  final String name;
  final String address;
  final LocationModel location;

  EstablishmentModel(
      {required this.id,
      required this.name,
      required this.address,
      required this.location})
      : super(id: id, name: name, address: address, location: location);

  factory EstablishmentModel.fromMap(Map<String, dynamic> map) {
    return EstablishmentModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      location: LocationModel.fromMap(
          Map<String, dynamic>.from(map['location'] as Map)),
    );
  }
}