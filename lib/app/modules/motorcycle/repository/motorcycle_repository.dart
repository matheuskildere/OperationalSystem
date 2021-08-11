import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/errors/failure.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/modules/motorcycle/errors/motorcycle_errors.dart';
import 'package:feelps/app/modules/motorcycle/models/register_motorcycle_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class IMotorcycleRepository {
  Future<Either<Failure, Unit>> registerMotorcycle(
      {required RegistermotorcycleRequest data});
}

class MotorcycleRepository implements IMotorcycleRepository {
  final FirebaseDatabase _database;
  final FirebaseAuth _auth;
  final ConnectivityService _connectivityService;
  final String tableName = 'deliveryman-${appFlavor!.title}';

  MotorcycleRepository(this._auth, this._database, this._connectivityService);

  @override
  Future<Either<Failure, Unit>> registerMotorcycle(
      {required RegistermotorcycleRequest data}) async {
    final result = await _connectivityService.isOnline;
    if (result.isLeft()) {
      return result;
    }
    final reference = _database.reference();

    try {
      final dataToSet = data.toMap();
      await reference
          .child(tableName)
          .child(_auth.currentUser!.uid)
          .child('motorcycle')
          .set(dataToSet);
    } catch (e) {
      return Left(RegisterMotorcycleError(
          title: "Não foi possível continuar",
          message:
              'Ocorreu um erro ao cadastrat a moto no sistema, tente novamente.'));
    }
    return Right(unit);
  }
}
