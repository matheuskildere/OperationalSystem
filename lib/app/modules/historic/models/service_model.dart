import 'package:feelps/app/modules/historic/models/delivery_adress_model.dart';
import 'package:feelps/app/modules/historic/models/deliveryman_service_model.dart';
import 'package:feelps/app/modules/historic/models/establishment_model.dart';
import 'package:feelps/app/modules/historic/models/observation_model.dart';

class ServiceModel {
  final String id;
  final String date;
  final String serviceName;
  final String price;
  final String status;
  final DeliveryAdressModel deliveryAddress;
  final DeliveryManServiceModel deliveryMan;
  final List<ObservationModel> observations;
  final EstablishmentModel establishment;

  ServiceModel(
      {required this.id,
      required this.date,
      required this.serviceName,
      required this.price,
      required this.status,
      required this.deliveryAddress,
      required this.deliveryMan,
      required this.observations,
      required this.establishment});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'serviceName': serviceName,
      'price': price,
      'status': status,
      'deliveryAddress': deliveryAddress.toMap(),
      'deliveryMan': deliveryMan.toMap(),
      'observations': observations.map((x) => x.toMap()).toList(),
      'establishment': establishment.toMap(),
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'] as String,
      date: map['date'] as String,
      serviceName: map['serviceName'] as String,
      price: map['price'] as String,
      status: map['status'] as String,
      deliveryAddress: DeliveryAdressModel.fromMap(
          map['deliveryAddress'] as Map<String, dynamic>),
      deliveryMan: DeliveryManServiceModel.fromMap(
          map['deliveryMan'] as Map<String, dynamic>),
      observations: map['observations'] == null
          ? []
          : (map['observations'] as List)
              .map((e) => ObservationModel.fromMap(e as Map<String, dynamic>))
              .toList(),
      establishment: EstablishmentModel.fromMap(
          map['establishment'] as Map<String, dynamic>),
    );
  }
}
