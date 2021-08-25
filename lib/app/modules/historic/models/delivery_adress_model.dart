import 'package:feelps/app/core/entities/service_entity.dart';

class DeliveryAdressModel extends DeliveryAdressEntity {
  final String receiver;
  final String adress;
  final double latitude;
  final double longitude;

  DeliveryAdressModel(
      {required this.receiver,
      required this.adress,
      required this.latitude,
      required this.longitude})
      : super(
            receiver: receiver,
            adress: adress,
            latitude: latitude,
            longitude: longitude);

  factory DeliveryAdressModel.fromMap(Map<String, dynamic> map) {
    return DeliveryAdressModel(
      receiver: map['receiver'] as String,
      adress: map['address'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }
}
