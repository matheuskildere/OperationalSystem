import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/errors/failure.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/modules/register/errors/register_errors.dart';
import 'package:feelps/app/modules/register/models/register_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class IRegisterRepository {
  Future<Either<Failure, Unit>> registerDeliveryman(
      {required RegisterRequest data});
  Future<Either<Failure, Unit>> checkCPF({required String cpf});
}

class RegisterRepository implements IRegisterRepository {
  final FirebaseDatabase _database;
  final FirebaseAuth _auth;
  final ConnectivityService _connectivityService;
  final String tableName = 'deliveryman-${appFlavor!.title}';

  RegisterRepository(this._auth, this._database, this._connectivityService);

  @override
  Future<Either<Failure, Unit>> registerDeliveryman(
      {required RegisterRequest data}) async {
    final result = await _connectivityService.isOnline;
    if (result.isLeft()) {
      return result;
    }

    final reference = _database.reference();

    late UserCredential userCredential;

    final resultCpfCheck = await checkCPF(cpf: data.cpf);
    if (resultCpfCheck.isLeft()) {
      return resultCpfCheck;
    }

    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: data.email, password: data.password);
    } catch (e) {
      return Left(EmailAlreadyUsedError(
          title: "Atenção",
          message:
              "O email informado já está cadastrado em nossa base de dados!"));
    }

    try {
      final dataToSet = data.toMap();
      dataToSet['id'] = userCredential.user!.uid;
      dataToSet['notificationToken'] =
          await FirebaseMessaging.instance.getToken();
      await reference
          .child(tableName)
          .child(userCredential.user!.uid)
          .set(dataToSet);
    } catch (e) {
      return Left(RegisterError(
          title: "Não foi possível continuar",
          message:
              'Ocorreu um erro ao realizar seu cadastro no sistema, tente novamente.'));
    }

    return Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> checkCPF({required String cpf}) async {
    final reference = _database.reference();

    try {
      final snap = await reference
          .child(tableName)
          .orderByChild('cpf')
          .equalTo(cpf)
          .once();
      if (snap.value != null) {
        return Left(CPFAlreadyUsedError(
            title: "Não foi possível continuar",
            message:
                'O CPF informado já está cadastrado em nossa base de dados!.'));
      }
    } catch (e) {
      return Left(RegisterError(
          title: "Não foi possível continuar",
          message: 'Ocorreu um erro ao validar seu CPF em nosso sistema!'));
    }

    return Right(unit);
  }
}
