import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/enum/status_enum.dart';
import 'package:feelps/app/core/utils/data_parser.dart';
import 'package:feelps/app/modules/historic/models/delivery_adress_model.dart';
import 'package:feelps/app/modules/historic/models/deliveryman_service_model.dart';
import 'package:feelps/app/modules/historic/models/establishment_model.dart';
import 'package:feelps/app/modules/historic/models/observation_model.dart';

class ServiceModel extends ServiceEntity {
  final String id;
  final DateTime? dateInit;
  final DateTime? dateEnd;
  final String serviceName;
  final double price;
  final DeliveryStatusEnum status;
  final DeliveryAdressModel deliveryAddress;
  final DeliveryManServiceModel deliveryMan;
  final List<ObservationModel> observations;
  final EstablishmentModel establishment;

  const ServiceModel(
      {required this.id,
      this.dateInit,
      this.dateEnd,
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
      dateInit: map['dateInit'] != null
          ? DateParser.getDateTime(map['dateInit'].toString())
          : null,
      dateEnd: map['dateEnd'] != null
          ? DateParser.getDateTime(map['dateEnd'].toString())
          : null,
      serviceName: map['serviceName'] as String,
      price: double.parse(map['price'].toString()),
      status: DeliveryStatusExt.getByString(map['status'] as String),
      deliveryAddress: DeliveryAdressModel.fromMap(
          Map<String, dynamic>.from(map['deliveryAddress'] as Map)),
      deliveryMan: DeliveryManServiceModel.fromMap(
          Map<String, dynamic>.from(map['deliveryMan'] as Map)),
      observations: map['observations'] == null
          ? []
          : (map['observations'] as List)
              .map((e) =>
                  ObservationModel.fromMap(Map<String, dynamic>.from(e as Map)))
              .toList(),
      establishment: EstablishmentModel.fromMap(
          Map<String, dynamic>.from(map['establishment'] as Map)),
    );
  }

  ServiceModel copyWith({
    String? id,
    DateTime? dateInit,
    DateTime? dateEnd,
    String? serviceName,
    double? price,
    DeliveryStatusEnum? status,
    DeliveryAdressModel? deliveryAddress,
    DeliveryManServiceModel? deliveryMan,
    List<ObservationModel>? observations,
    EstablishmentModel? establishment,
  }) {
    return ServiceModel(
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
