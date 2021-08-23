import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/errors/failure.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/modules/historic/errors/get_deliveryman_services_error.dart';
import 'package:feelps/app/modules/historic/models/service_model.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class IHistoricRepository {
  Future<Either<Failure, List<ServiceEntity>>> getHistoric(String userId);
}

class HistoricRepository extends IHistoricRepository {
  final IConnectivityService _connectivityService;
  final FirebaseDatabase _database;
  final String tableNameServices = 'services-${appFlavor!.title}';
  final String tableNameDelMan = 'deliveryman-${appFlavor!.title}';

  HistoricRepository(this._connectivityService, this._database);

  @override
  Future<Either<Failure, List<ServiceEntity>>> getHistoric(
      String userId) async {
    @override
    final result = await _connectivityService.isOnline;
    if (result.isLeft()) {
      //TODO:return result;
    }
    final reference = _database.reference();

    final List<ServiceModel> services = [];
    try {
      final snapListId = await reference
          .child(tableNameDelMan)
          .child(userId)
          .child('servicesHistory')
          .once();
      final List<String> deliveryManServicesList =
          snapListId.value as List<String>;

      for (final id in deliveryManServicesList) {
        final snapshotServices =
            await reference.child(tableNameServices).child(id).once();
        final ServiceModel service = ServiceModel.fromMap(
            snapshotServices.value as Map<String, dynamic>);
        services.add(service);
      }
      return Right(services);
    } catch (e) {
      return Left(GetDeliveryManServicesError(
          title: "Não foi possível continuar",
          message:
              'Ocorreu um erro ao buscar o seu histórico de entregas, tente novamente.'));
    }
  }
}
