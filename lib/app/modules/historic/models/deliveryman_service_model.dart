import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/modules/historic/models/location_model.dart';

class DeliveryManServiceModel extends DeliveryManServiceEntity {
  final String id;
  final String fullName;
  final String notificationToken;
  final LocationModel location;
  final String photoUrl;

  DeliveryManServiceModel({
    required this.id,
    required this.fullName,
    required this.notificationToken,
    required this.location,
    required this.photoUrl,
  }) : super(
          id: id,
          fullName: fullName,
          notificationToken: notificationToken,
          location: location,
          photoUrl: photoUrl,
        );

  factory DeliveryManServiceModel.fromMap(Map<String, dynamic> map) {
    return DeliveryManServiceModel(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      notificationToken: map['notificationToken'] as String,
      photoUrl: map['photoUrl'] as String,
      location: LocationModel.fromMap(
          Map<String, dynamic>.from(map['location'] as Map)),
    );
  }
}
