import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/errors/failure.dart';

class NoConnectionError extends Failure {
  final String title;
  final String message;
  NoConnectionError({required this.title, required this.message});
}

abstract class IConnectivityService {
  Future<Either<Failure, Unit>> get isOnline;
}

class ConnectivityService implements IConnectivityService {
  final Connectivity _connectivity;

  ConnectivityService(this._connectivity);

  @override
  Future<Either<Failure, Unit>> get isOnline async {
    final result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      return Right(unit);
    } else {
      return Left(NoConnectionError(
          title: "Atenção",
          message: "Você não possui conexão com a internet!"));
    }
  }
}
