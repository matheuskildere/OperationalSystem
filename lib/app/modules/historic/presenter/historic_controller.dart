import 'package:feelps/app/modules/historic/repositories/historic_repository.dart';
import 'package:mobx/mobx.dart';

part 'historic_controller.g.dart';

class HistoricController = _HistoricController with _$HistoricController;

abstract class _HistoricController with Store {
  final IHistoricRepository _repository;

  _HistoricController(this._repository);
}
