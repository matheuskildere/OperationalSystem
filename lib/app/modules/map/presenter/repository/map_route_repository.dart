import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/errors/failure.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/modules/historic/models/service_model.dart';
import 'package:feelps/app/modules/map/errors/map_error.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class IMapRouteRepository {
  Future<Either<Failure, ServiceEntity>> getService(
      {required String serviceId});
}

class MapRouteRepository implements IMapRouteRepository {
  final FirebaseDatabase _database;
  final ConnectivityService _connectivityService;
  final String tableName = 'service-${appFlavor!.title}';

  MapRouteRepository(this._database, this._connectivityService);

  @override
  Future<Either<Failure, ServiceEntity>> getService(
      {required String serviceId}) async {
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


    await reference
        .child(tableName)
        .child(serviceId)
        .update({'status': 'Aceito'});

    await reference
        .child(tableName)
        .child(serviceId)
        .update({'status': 'A caminho da retirada'});
        
    final snapshotService =
        await reference.child(tableName).child(serviceId).once();
    if (snapshotService.value == null) {
      return Left(GetDirectionsInfoError(
          title: "Não foi possível continuar",
          message: 'Ocorreu um erro ao buscar os dados deste serviço!'));
    }
    final snapMap = Map<String, dynamic>.from(snapshotService.value as Map);
    final service = ServiceModel.fromMap(snapMap);
    return Right(service);
  }
}
