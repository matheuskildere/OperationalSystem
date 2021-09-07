// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historic_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoricController on _HistoricController, Store {
  final _$dialogDataAtom = Atom(name: '_HistoricController.dialogData');

  @override
  DialogDataEntity? get dialogData {
    _$dialogDataAtom.reportRead();
    return super.dialogData;
  }

  @override
  set dialogData(DialogDataEntity? value) {
    _$dialogDataAtom.reportWrite(value, super.dialogData, () {
      super.dialogData = value;
    });
  }

  final _$servicesAtom = Atom(name: '_HistoricController.services');

  @override
  List<ServiceEntity>? get services {
    _$servicesAtom.reportRead();
    return super.services;
  }

  @override
  set services(List<ServiceEntity>? value) {
    _$servicesAtom.reportWrite(value, super.services, () {
      super.services = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_HistoricController.errorMessage');

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$serviceIdAtom = Atom(name: '_HistoricController.serviceId');

  @override
  String? get serviceId {
    _$serviceIdAtom.reportRead();
    return super.serviceId;
  }

  @override
  set serviceId(String? value) {
    _$serviceIdAtom.reportWrite(value, super.serviceId, () {
      super.serviceId = value;
    });
  }

  final _$directionsAtom = Atom(name: '_HistoricController.directions');

  @override
  DirectionsModel? get directions {
    _$directionsAtom.reportRead();
    return super.directions;
  }

  @override
  set directions(DirectionsModel? value) {
    _$directionsAtom.reportWrite(value, super.directions, () {
      super.directions = value;
    });
  }

  final _$getServicesAsyncAction =
      AsyncAction('_HistoricController.getServices');

  @override
  Future<void> getServices() {
    return _$getServicesAsyncAction.run(() => super.getServices());
  }

  @override
  String toString() {
    return '''
dialogData: ${dialogData},
services: ${services},
errorMessage: ${errorMessage},
serviceId: ${serviceId},
directions: ${directions}
    ''';
  }
}
