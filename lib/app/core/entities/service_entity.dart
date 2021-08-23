import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String id;
  final DateTime dateInit;
  final DateTime dateEnd;
  final String serviceName;
  final double price;
  final String status;
  final DeliveryAdressEntity deliveryAddress;
  final DeliveryManServiceEntity deliveryMan;
  final List<ObservationEntity> observations;
  final EstablishmentEntity establishment;

  const ServiceEntity(
      {required this.id,
      required this.dateInit,
      required this.dateEnd,
      required this.serviceName,
      required this.price,
      required this.status,
      required this.deliveryAddress,
      required this.deliveryMan,
      required this.observations,
      required this.establishment});

  @override
  List<Object?> get props => [id];
}

class DeliveryAdressEntity {
  final String receiver;
  final String adress;
  final double latitude;
  final double longitude;

  DeliveryAdressEntity(
      {required this.receiver,
      required this.adress,
      required this.latitude,
      required this.longitude});
}

class DeliveryManServiceEntity {
  final String id;
  final String fullName;
  final String notificationToken;
  final LocationEntity location;

  DeliveryManServiceEntity({
    required this.id,
    required this.fullName,
    required this.notificationToken,
    required this.location,
  });
}

class LocationEntity {
  final double latitude;
  final double longitude;

  LocationEntity({
    required this.latitude,
    required this.longitude,
  });
}

class ObservationEntity {
  final String status;
  final String observation;
  final DateTime createdAt;

  ObservationEntity(
      {required this.status,
      required this.observation,
      required this.createdAt});
}

class EstablishmentEntity {
  final String id;
  final String name;
  final String address;
  final LocationEntity location;

  EstablishmentEntity(
      {required this.id,
      required this.name,
      required this.address,
      required this.location});
}
