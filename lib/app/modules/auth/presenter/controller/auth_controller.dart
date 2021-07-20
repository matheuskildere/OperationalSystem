import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/core/validations/app_validations.dart';
import 'package:feelps/app/modules/auth/models/login_request.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthController with _$AuthController;

abstract class _AuthController with Store {
  @observable
  String? email;

  @observable
  String? password;

  @observable
  DialogDataEntity? errorData;

  @computed
  bool get isEmailValid => AppValidations.isEmailValid(email);

  @computed
  bool get isPasswordValid => password != null && password!.length > 6;

  @action
  Future<void> makeLogin() async {
    errorData = null;
    await Modular.get<AuthStore>()
        .makeLogin(data: LoginRequest(email!, password!));
    errorData = Modular.get<AuthStore>().errorData;
  }

  @action
  Future<void> recoverPassword() async {
    errorData = null;
    await Modular.get<AuthStore>().recoverPassword(email: email!);
    errorData = Modular.get<AuthStore>().errorData;
  }
}
