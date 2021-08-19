import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/errors/failure.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/modules/historic/errors/get_deliveryman_services_error.dart';
import 'package:feelps/app/modules/historic/models/service_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class IHistoricRepository {
  Future<Either<Failure, List<ServiceModel>>> getHistoric();
}

class HistoricRepository extends IHistoricRepository {
  final IConnectivityService _connectivityService;
  final FirebaseAuth _auth;
  final FirebaseDatabase _database;
  final String tableNameServices = 'services-${appFlavor!.title}';
  final String tableNameDelMan = 'deliveryman-${appFlavor!.title}';

  HistoricRepository(this._connectivityService, this._database, this._auth);

  @override
  Future<Either<Failure, List<ServiceModel>>> getHistoric() async {
    @override
    final result = await _connectivityService.isOnline;
    if (result.isLeft()) {
      // return result;
      //comentei pq não sei como resolver
    }
    final reference = _database.reference();

    final List<ServiceModel> services = [];
    try {
      final List<String> deliveryManServicesList = (await reference
              .child(tableNameDelMan)
              .child(_auth.currentUser!.uid)
              .child('servicesHistory')
              .once())
          .value as List<String>;

      for (final String id in deliveryManServicesList) {
        final ServiceModel service = ServiceModel.fromMap((await reference
                .child(tableNameServices)
                .orderByChild('id')
                .equalTo(id)
                .once())
            .value as Map<String, dynamic>);
        services.add(service);
      }
      return right(services);
    } catch (e) {
      return Left(GetDeliveryManServicesError(
          title: "Não foi possível continuar",
          message:
              'Ocorreu um erro ao buscar o seu histórico de entregas, tente novamente.'));
    }
  }
}
