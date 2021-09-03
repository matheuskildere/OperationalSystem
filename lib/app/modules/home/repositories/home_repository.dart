import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/errors/failure.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/modules/home/errors/home_errors.dart';
import 'package:feelps/app/modules/home/models/change_status_request.dart';
import 'package:feelps/app/modules/home/models/last_location_request.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class IHomeRepository {
  Future<Either<Failure, Unit>> changeStatusAvaliable(
      {required ChangeStatusRequest request});
  Future<Either<Failure, bool>> getStatusAvaliable(
      {required String deliveryManId});
  Future<Either<Failure, Unit>> updateLastLocation(
      {required LastLocationRequest request});
}

class HomeRepository extends IHomeRepository {
  final IConnectivityService _connectivityService;
  final FirebaseDatabase _database;
  final String tableName = 'deliveryman-${appFlavor!.title}';

  HomeRepository(this._connectivityService, this._database);

  @override
  Future<Either<Failure, Unit>> changeStatusAvaliable(
      {required ChangeStatusRequest request}) async {
    final result = await _connectivityService.isOnline;
    result.fold((l) {
      return Left(l);
    }, (r) {});
    final reference = _database.reference();

    try {
      await reference
          .child(tableName)
          .child(request.deliveryManId)
          .update(request.toMap());
      return Right(unit);
    } catch (e) {
      return Left(ChangeStatusError(
          title: "Ocorreu um erro",
          message: 'Não foi possível alterar sua disponibilidade'));
    }
  }

  @override
  Future<Either<Failure, bool>> getStatusAvaliable(
      {required String deliveryManId}) async {
    final result = await _connectivityService.isOnline;
    result.fold((l) {
      return Left(l);
    }, (r) {});
    final reference = _database.reference();

    try {
      final resultSnapshot = await reference
          .child(tableName)
          .child(deliveryManId)
          .child('isAvaliable')
          .once();
      return Right(resultSnapshot.value as bool);
    } catch (e) {
      return Left(ChangeStatusError(
          title: "Ocorreu um erro",
          message: 'Não buscar seu status de disponibilidade'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateLastLocation(
      {required LastLocationRequest request}) async {
    final reference = _database.reference();

    try {
      await reference
          .child(tableName)
          .child(request.deliveryManId)
          .update({'lastLocation': request.toMap()});
    } catch (e) {
      print(e);
    }

    return Right(unit);
  }
}
