import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/entities/motorcycle_entity.dart';
import 'package:feelps/app/core/errors/failure.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/modules/motorcycle/errors/motorcycle_errors.dart';
import 'package:feelps/app/modules/motorcycle/models/motorcicly_color_model.dart';
import 'package:feelps/app/modules/motorcycle/models/register_motorcycle_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class IMotorcycleRepository {
  Future<Either<Failure, Unit>> registerMotorcycle(
      {required RegisterMotorcycleRequest data});
  Future<Either<Failure, MotorcycleEntity?>> getMotorcycle();
  Future<Either<Failure, Unit>> deleteMotorcycle();
  Future<Either<Failure, List<MotorciclyColorEntity>>> getColors();
}

class MotorcycleRepository implements IMotorcycleRepository {
  final FirebaseDatabase _database;
  final FirebaseAuth _auth;
  final ConnectivityService _connectivityService;
  final String tableName = 'deliveryman-${appFlavor!.title}';

  MotorcycleRepository(this._auth, this._database, this._connectivityService);

  @override
  Future<Either<Failure, Unit>> registerMotorcycle(
      {required RegisterMotorcycleRequest data}) async {
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

  @override
  Future<Either<Failure, MotorcycleEntity?>> getMotorcycle() async {
    final result = await _connectivityService.isOnline;
    if (result.isLeft()) {
      // return result;
      //comentei pq não sei como resolver
    }
    final reference = _database.reference();

    try {
      final DataSnapshot a = await reference
          .child(tableName)
          .child(_auth.currentUser!.uid)
          .child('motorcycle')
          .once();
      if (a.value == null) {
        return Right(null);
      }
      final Map<String, dynamic> b = Map<String, dynamic>.from(a.value as Map);
      return Right(MotorcycleEntity(
        brand: b['brand'] as String,
        model: b['model'] as String,
        year: b['year'] as int,
        photoUrl: b['photoUrl'] as String,
        color: MotorciclyColorModel.fromMap(
            Map<String, dynamic>.from(b['color'] as Map)),
        plate: b['plate'] as String,
      ));
    } catch (e) {
      return Left(RegisterMotorcycleError(
          title: "Não foi possível continuar",
          message:
              'Ocorreu um erro ao cadastratr a moto no sistema, tente novamente.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMotorcycle() async {
    final result = await _connectivityService.isOnline;
    if (result.isLeft()) {
      return result;
    }
    final reference = _database.reference();

    try {
      await reference
          .child(tableName)
          .child(_auth.currentUser!.uid)
          .child('motorcycle')
          .remove();
    } catch (e) {
      return Left(RegisterMotorcycleError(
          title: "Não foi possível continuar",
          message:
              'Ocorreu um erro ao cadastrat a moto no sistema, tente novamente.'));
    }

    return Right(unit);
  }

  @override
  Future<Either<Failure, List<MotorciclyColorEntity>>> getColors() async {
    final reference = _database.reference();

    try {
      final DataSnapshot a = await reference
          .child('parameters')
          .child('motorcycle')
          .child('color')
          .once();
      if (a.value == null) {
        return Left(GetColorsMotorcycleError(
            title: "Não foi possível resgatar as cores",
            message:
                'Entre em contato com o suporte, pois não há cores disponíveis!'));
      }
      final List<MotorciclyColorModel> colors = [];
      for (final item in a.value) {
        colors.add(MotorciclyColorModel.fromMap(
            Map<String, dynamic>.from(item as Map)));
      }
      return Right(colors);
    } catch (e) {
      return Left(GetColorsMotorcycleError(
          title: "Não foi possível resgatar as cores",
          message:
              'Ocorreu um erro ao buscar as cores para cadastro de motocicleta.'));
    }
  }
}