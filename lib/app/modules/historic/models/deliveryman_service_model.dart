import 'package:feelps/app/modules/historic/models/location_model.dart';

class DeliveryManServiceModel {
  final String id;
  final String fullName;
  final String notificationToken;
  final LocationModel location;

  DeliveryManServiceModel({
    required this.id,
    required this.fullName,
    required this.notificationToken,
    required this.location,
  });

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
