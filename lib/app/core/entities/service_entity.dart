import 'package:equatable/equatable.dart';

import 'package:feelps/app/core/enum/status_enum.dart';

class ServiceEntity extends Equatable {
  final String id;
  final DateTime? dateInit;
  final DateTime? dateEnd;
  final String serviceName;
  final double price;
  final DeliveryStatusEnum status;
  final DeliveryAdressEntity deliveryAddress;
  final DeliveryManServiceEntity deliveryMan;
  final List<ObservationEntity> observations;
  final EstablishmentEntity establishment;

  const ServiceEntity(
      {required this.id,
      this.dateInit,
      this.dateEnd,
      required this.serviceName,
      required this.price,
      required this.status,
      required this.deliveryAddress,
      required this.deliveryMan,
      required this.observations,
      required this.establishment});

  @override
  List<Object?> get props => [id];

  ServiceEntity copyWith({
    String? id,
    DateTime? dateInit,
    DateTime? dateEnd,
    String? serviceName,
    double? price,
    DeliveryStatusEnum? status,
    DeliveryAdressEntity? deliveryAddress,
    DeliveryManServiceEntity? deliveryMan,
    List<ObservationEntity>? observations,
    EstablishmentEntity? establishment,
  }) {
    return ServiceEntity(
      id: id ?? this.id,
      dateInit: dateInit ?? this.dateInit,
      dateEnd: dateEnd ?? this.dateEnd,
      serviceName: serviceName ?? this.serviceName,
      price: price ?? this.price,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryMan: deliveryMan ?? this.deliveryMan,
      observations: observations ?? this.observations,
      establishment: establishment ?? this.establishment,
    );
  }
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
  final String photoUrl;

  DeliveryManServiceEntity({
    required this.id,
    required this.fullName,
    required this.notificationToken,
    required this.location,
    required this.photoUrl,
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
