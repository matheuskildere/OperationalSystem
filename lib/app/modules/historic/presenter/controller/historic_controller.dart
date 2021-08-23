import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/modules/historic/repositories/historic_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'historic_controller.g.dart';

class HistoricController = _HistoricController with _$HistoricController;

abstract class _HistoricController with Store {
  final IHistoricRepository _repository;

  _HistoricController(this._repository);

  @observable
  DialogDataEntity? dialogData;

  @observable
  List<ServiceEntity> services = [];

  @observable
  String? errorMessage;

  @action
  Future<void> getServices() async {
    final authStore = Modular.get<AuthStore>();

    final result = await _repository.getHistoric(authStore.deliveryman!.id!);

    result.fold((l) {
      dialogData = DialogDataEntity(title: l.title, description: l.message);
      errorMessage = 'Não foi possível buscar seus serviços';
    }, (r) {
      services = r;
      if (services.isEmpty) errorMessage = 'Não há serviços registrados ainda!';
    });
  }
}
