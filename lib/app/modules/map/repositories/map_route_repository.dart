import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/enum/status_enum.dart';
import 'package:feelps/app/core/errors/failure.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/core/utils/data_parser.dart';
import 'package:feelps/app/modules/historic/models/service_model.dart';
import 'package:feelps/app/modules/map/errors/map_error.dart';
import 'package:feelps/app/modules/map/models/last_location_request.dart';
import 'package:feelps/app/modules/map/models/status_update_model.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class IMapRouteRepository {
  Future<Either<Failure, ServiceEntity>> getService(
      {required String serviceId, required String deliveryManId});
  Future<Either<Failure, ServiceEntity>> updateStatus(
      {required StatusUpdateModel request});
  Future<Either<Failure, Unit>> updateLastLocation(
      {required LastLocationRequest request});
}

class MapRouteRepository implements IMapRouteRepository {
  final FirebaseDatabase _database;
  final ConnectivityService _connectivityService;
  final String tableName = 'service-${appFlavor!.title}';
  final String tableNameDeliveryMan = 'deliveryman-${appFlavor!.title}';

  MapRouteRepository(this._database, this._connectivityService);

  @override
  Future<Either<Failure, ServiceEntity>> getService(
      {required String serviceId, required String deliveryManId}) async {
    final result = await _connectivityService.isOnline;
    if (result.isLeft()) {
      return result.fold((l) {
        return Left(l);
      }, (r) {
        return Left(NoConnectionError(
            title: "Atenção",
            message: "Você não possui conexão com a internet!"));
      });
    }
    final reference = _database.reference();

    await reference.child(tableName).child(serviceId).update({
      'dateInit': DateParser.getDateStringEn(DateTime.now()),
      'status': 'Aceito'
    });

    await reference
        .child(tableName)
        .child(serviceId)
        .update({'status': 'A caminho da retirada'});

    await updateDeliveryMan(serviceId: serviceId, deliveryManId: deliveryManId);

    final snapshotService =
        await reference.child(tableName).child(serviceId).once();
    if (snapshotService.value == null) {
      return Left(GetDirectionsInfoError(
          title: "Não foi possível continuar",
          message: 'Ocorreu um erro ao buscar os dados deste serviço!'));
    }
    final snapMap = Map<String, dynamic>.from(snapshotService.value as Map);
    var service = ServiceModel.fromMap(snapMap);
    service = service.copyWith(status: DeliveryStatusEnum.wayToPickup);
    return Right(service);
  }

  @override
  Future<Either<Failure, ServiceEntity>> updateStatus(
      {required StatusUpdateModel request}) async {
    final reference = _database.reference();

    if (request.observation != null) {
      final snapService =
          await reference.child(tableName).child(request.serviceId).once();
      if (snapService.value['observations'] != null) {
        await reference.child(tableName).child(request.serviceId).update({
          'status': request.status,
          'observations': [
            {
              'createdAt': DateParser.getDateStringEn(DateTime.now()),
              'description': request.observation,
              'status': request.status
            },
            ...snapService.value['observations']
          ]
        });
      } else {
        await reference.child(tableName).child(request.serviceId).update({
          'status': request.status,
          'observations': [
            {
              'createdAt': DateParser.getDateStringEn(DateTime.now()),
              'description': request.observation,
              'status': request.status
            }
          ]
        });
      }
    } else {
      await reference
          .child(tableName)
          .child(request.serviceId)
          .update({'status': request.status});
    }
    if (request.status == 'Finalizado') {
      await reference
          .child(tableName)
          .child(request.serviceId)
          .update({'dateEnd': DateParser.getDateStringEn(DateTime.now())});
    }
    final snapshotService =
        await reference.child(tableName).child(request.serviceId).once();
    if (snapshotService.value == null) {
      return Left(GetDirectionsInfoError(
          title: "Não foi possível continuar",
          message: 'Ocorreu um erro ao buscar os dados deste serviço!'));
    }
    final snapMap = Map<String, dynamic>.from(snapshotService.value as Map);
    final service = ServiceModel.fromMap(snapMap);

    return Right(service);
  }

  @override
  Future<Either<Failure, Unit>> updateLastLocation(
      {required LastLocationRequest request}) async {
    final reference = _database.reference();

    try {
      await reference
          .child(tableNameDeliveryMan)
          .child(request.deliveryManId)
          .update({'lastLocation': request.toMap()});
    } catch (e) {
      print(e);
    }

    return Right(unit);
  }

  Future<void> updateDeliveryMan(
      {required String serviceId, required String deliveryManId}) async {
    final reference = _database.reference();
    final snapDeliveryMan =
        await reference.child(tableNameDeliveryMan).child(deliveryManId).once();

    if (snapDeliveryMan.value['servicesHistory'] != null) {
      await reference.child(tableNameDeliveryMan).child(deliveryManId).update({
        'isAvaliable': false,
        'servicesHistory': [
          serviceId,
          ...snapDeliveryMan.value['servicesHistory']
        ]
      });
    } else {
      await reference.child(tableNameDeliveryMan).child(deliveryManId).update({
        'isAvaliable': false,
        'servicesHistory': [serviceId]
      });
    }
  }
}
