import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/entities/deliveryman_entity.dart';
import 'package:feelps/app/core/errors/failure.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/modules/auth/errors/auth_erros.dart';
import 'package:feelps/app/modules/auth/models/deliveryman_response.dart';
import 'package:feelps/app/modules/auth/models/login_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class IAuthRepository {
  Future<Either<Failure, DeliverymanEntity>> loginWithEmail(
      {required LoginRequest data});
  Future<Either<Failure, DeliverymanEntity>> getCurrentUser();
  Future<Either<Failure, Unit>> logout();
}

class AuthRepository implements IAuthRepository {
  final FirebaseDatabase _database;
  final FirebaseAuth _auth;
  final ConnectivityService _connectivityService;

  AuthRepository(this._auth, this._database, this._connectivityService);

  @override
  Future<Either<Failure, DeliverymanEntity>> getCurrentUser() async {
    final result = await _connectivityService.isOnline;
    result.fold((l) {
      return Left(l);
    }, (r) {});
    final reference = _database.reference();
    final user = _auth.currentUser;

    if (user == null) {
      return Left(UserNotLoggedError(
          title: "Ocorreu um erro",
          message: "Sua sessão expirou, faça login e tente novamente!"));
    }

    final dataSnapshotPages =
        await reference.child("deliveryman").child(user.uid).once();

    if (dataSnapshotPages.value == null) {
      return Left(GetLoggedUserError(
          title: "Ocorreu um erro",
          message: "Não foi possível recuperar seus dados de usuário"));
    }
    final userData = DelvierymanResponse.fromMap(
        Map<String, dynamic>.from(dataSnapshotPages.value as Map));

    return Right(userData);
  }

  @override
  Future<Either<Failure, DeliverymanEntity>> loginWithEmail(
      {required LoginRequest data}) async {
    final result = await _connectivityService.isOnline;
    result.fold((l) {
      return Left(l);
    }, (r) {});
    try {
      await _auth.signInWithEmailAndPassword(
          email: data.email, password: data.password);
    } catch (e) {
      Left(AuthError(
          title: "Atenção", message: "Email e/ou Senha incorretos!!"));
    }
    return getCurrentUser();
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    final result = await _connectivityService.isOnline;
    result.fold((l) {
      return Left(l);
    }, (r) {});
    try {
      await _auth.signOut();
    } catch (e) {
      return Left(LogoutError(
          title: "Ocorreu um erro",
          message: "Tivemos um problema ao fazer logout, tente novamente!"));
    }
    return Right(unit);
  }
}
