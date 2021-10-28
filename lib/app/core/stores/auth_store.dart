import 'package:feelps/app/core/entities/deliveryman_entity.dart';
import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/theme/app_routes.dart';
import 'package:feelps/app/modules/auth/models/login_request.dart';
import 'package:feelps/app/modules/auth/repositories/auth_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final IAuthRepository _repository;

  _AuthStore(this._repository);

  @observable
  DialogDataEntity? errorData;

  @observable
  DeliverymanEntity? deliveryman;

  @action
  Future<void> makeLogin({required LoginRequest data}) async {
    errorData = null;
    final result = await _repository.loginWithEmail(data: data);
    result.fold((l) {
      errorData = DialogDataEntity(title: l.title, description: l.message);
    }, (r) {
      deliveryman = r;
    });
  }

  @action
  Future<void> getCurrentUser() async {
    errorData = null;
    final result = await _repository.getCurrentUser();
    result.fold((l) {
      errorData = DialogDataEntity(title: l.title, description: l.message);
    }, (r) {
      deliveryman = r;
    });
  }

  @action
  Future<void> recoverPassword({required String email}) async {
    final result = await _repository.resetPassword(email: email);
    result.fold((l) {
      errorData = DialogDataEntity(title: l.title, description: l.message);
    }, (r) {});
  }

  @action
  Future<void> logout() async {
    final result = await _repository.logout();
    result.fold((l) {
      errorData = DialogDataEntity(title: l.title, description: l.message);
    }, (r) {
      Modular.to.navigate(AppRoutes.oborading);
    });
  }
}
