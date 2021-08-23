import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/modules/historic/models/location_model.dart';

class DeliveryManServiceModel extends DeliveryManServiceEntity {
  final String id;
  final String fullName;
  final String notificationToken;
  final LocationModel location;

  DeliveryManServiceModel({
    required this.id,
    required this.fullName,
    required this.notificationToken,
    required this.location,
  }): super(
    id: id,
    fullName: fullName,
    notificationToken: notificationToken,
    location: location,
    );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'notificationToken': notificationToken,
      'location': location.toMap(),
    };
  }

  factory DeliveryManServiceModel.fromMap(Map<String, dynamic> map) {
    return DeliveryManServiceModel(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      notificationToken: map['notificationToken'] as String,
      location: LocationModel.fromMap(map['location'] as Map<String, dynamic>),
    );
  }
}
