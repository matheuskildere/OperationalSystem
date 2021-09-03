import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/modules/home/models/change_status_request.dart';
import 'package:feelps/app/modules/home/models/last_location_request.dart';
import 'package:feelps/app/modules/home/repositories/home_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  final IHomeRepository _repository;

  _HomeController(this._repository);

  @observable
  bool isAvaliable = false;

  @action
  Future<void> isAvaliableChanged({required bool value}) async {
    final authStore = Modular.get<AuthStore>();
    final result = await _repository.changeStatusAvaliable(
        request: ChangeStatusRequest(
            deliveryManId: authStore.deliveryman!.id!, isAvaliable: value));

    result.fold((l) {
      print('Error: $l');
    }, (r) {
      isAvaliable = value;
    });
  }

  @action
  Future<void> getStatusAvaliable() async {
    final authStore = Modular.get<AuthStore>();
    final result = await _repository.getStatusAvaliable(
        deliveryManId: authStore.deliveryman!.id!);

    result.fold((l) {
      print('Error: $l');
    }, (r) {
      isAvaliable = r;
    });
  }

  @action
  Future<void> updateLastLocation(
      {required double latitude, required double longitude}) async {
    final idDeliveryMan = Modular.get<AuthStore>().deliveryman!.id!;
    final result = await _repository.updateLastLocation(
        request: LastLocationRequest(
            latitude: latitude,
            longitude: longitude,
            deliveryManId: idDeliveryMan));

    result.fold((l) {}, (r) {});
  }
}
