import 'package:feelps/app/modules/register/repositories/resgister_repository.dart';
import 'package:mobx/mobx.dart';

part 'register_controller.g.dart';

class RegisterController = _RegisterController with _$RegisterController;

abstract class _RegisterController with Store{
  final IRegisterRepository _repository;

  _RegisterController(this._repository);
  
  @observable
  String? fullName;

  @observable
  String? cpf;
  
  @observable
  String? phoneNumber;
  
  @observable
  DateTime? birthday;
}