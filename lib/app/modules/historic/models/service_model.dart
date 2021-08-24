import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/utils/data_parser.dart';
import 'package:feelps/app/modules/historic/models/delivery_adress_model.dart';
import 'package:feelps/app/modules/historic/models/deliveryman_service_model.dart';
import 'package:feelps/app/modules/historic/models/establishment_model.dart';
import 'package:feelps/app/modules/historic/models/observation_model.dart';

class ServiceModel extends ServiceEntity {
  final String id;
  final DateTime dateInit;
  final DateTime dateEnd;
  final String serviceName;
  final double price;
  final String status;
  final DeliveryAdressModel deliveryAddress;
  final DeliveryManServiceModel deliveryMan;
  final List<ObservationModel> observations;
  final EstablishmentModel establishment;

  const ServiceModel(
      {required this.id,
      required this.dateInit,
      required this.dateEnd,
      required this.serviceName,
      required this.price,
      required this.status,
      required this.deliveryAddress,
      required this.deliveryMan,
      required this.observations,
      required this.establishment})
      : super(
            id: id,
            dateInit: dateInit,
            dateEnd: dateEnd,
            serviceName: serviceName,
            price: price,
            status: status,
            deliveryAddress: deliveryAddress,
            deliveryMan: deliveryMan,
            observations: observations,
            establishment: establishment);

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'] as String,
      dateInit: DateParser.getDateTime(map['dateInit'].toString()),
      dateEnd: DateParser.getDateTime(map['dateEnd'].toString()),
      serviceName: map['serviceName'] as String,
      price: double.parse(map['price'].toString()),
      status: map['status'] as String,
      deliveryAddress: DeliveryAdressModel.fromMap(
          Map<String, dynamic>.from(map['deliveryAddress'] as Map)),
      deliveryMan: DeliveryManServiceModel.fromMap(
          Map<String, dynamic>.from(map['deliveryMan'] as Map)),
      observations: map['observations'] == null
          ? []
          : (map['observations'] as List)
              .map((e) => ObservationModel.fromMap(e as Map<String, dynamic>))
              .toList(),
      establishment: EstablishmentModel.fromMap(
          Map<String, dynamic>.from(map['establishment'] as Map)),
    );
  }
}
