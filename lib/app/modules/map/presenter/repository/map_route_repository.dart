import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/errors/failure.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/modules/historic/models/service_model.dart';
import 'package:feelps/app/modules/map/errors/map_error.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class IMapRouteRepository {
  Future<Either<Failure, ServiceEntity>> getRoute({required String serviceId});
}

class MapRouteRepository implements IMapRouteRepository {
  final FirebaseDatabase _database;
  final ConnectivityService _connectivityService;
  final String tableName = 'service-${appFlavor!.title}';

  MapRouteRepository(this._database, this._connectivityService);

  @override
  Future<Either<Failure, ServiceEntity>> getRoute(
      {required String serviceId}) async {
    @override
    final result = await _connectivityService.isOnline;
    if (result.isLeft()) {
      //TODO:return result;
    }
    final reference = _database.reference();

    try {
      final service = ServiceModel.fromMap(Map<String, dynamic>.from(
          (await reference.child(tableName).child(id.toString()).once()).value
              as Map));
      return Right(service);
    } catch (e) {
      return Left(GetServiceInfoError(
          title: "Não foi possível continuar",
          message: 'Ocorreu um erro ao buscar os dados da entrega.'));
    }
  }
}
