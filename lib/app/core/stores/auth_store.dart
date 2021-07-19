import 'package:feelps/app/core/entities/deliveryman_entity.dart';
import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/modules/auth/models/login_request.dart';
import 'package:feelps/app/modules/auth/repositories/auth_repository.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final AuthRepository _repository;

  _AuthStore(this._repository);

  @observable
  DialogDataEntity? errorData;

  @observable
  DeliverymanEntity? deliveryman;

  @action
  Future<void> makeLogin({required LoginRequest data}) async {
    final result = await _repository.loginWithEmail(data: data);
    result.fold((l) {
      errorData = DialogDataEntity(title: l.title, description: l.message);
    }, (r) {
      deliveryman = r;
    });
  }
}
