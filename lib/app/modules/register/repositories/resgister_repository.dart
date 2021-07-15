import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/errors/failure.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/modules/register/errors/register_errors.dart';
import 'package:feelps/app/modules/register/models/register_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class IRegisterRepository{
  Future<Either<Failure, Unit>> registerDeliveryman({required RegisterRequest data});
}

class RegisterRepository implements IRegisterRepository{
  final FirebaseDatabase _database;
  final FirebaseAuth _auth;
  final ConnectivityService _connectivityService;

  RegisterRepository(this._auth, this._database, this._connectivityService);

  @override
  Future<Either<Failure, Unit>> registerDeliveryman({required RegisterRequest data}) async {
    final result = await _connectivityService.isOnline;
    result.fold((l) {
      return Left(l);
    }, (r) {});
    
    final reference = _database.reference();

    late UserCredential userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: data.email, password: data.password);
    } catch (e) {
      return Left(EmailAlreadyUsedError(
          title: "Atenção",
          message: "O email informado já está cadastrado em nossa base de dados!."));
    }

    try {
      final dataToSet = data.toMap();
      dataToSet['id'] = userCredential.user!.uid;
      await reference
          .child('deliveryman')
          .child(userCredential.user!.uid)
          .set(dataToSet);
    } catch (e) {
      return Left(RegisterError(title: "Não foi possível continuar",
        message: 'Ocorreu um erro ao realizar seu cadastro no sistema, tente novamente.'));
    }

    return Right(unit);
  }
}