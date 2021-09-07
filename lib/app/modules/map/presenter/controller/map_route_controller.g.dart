// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_route_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MapRouteController on _MapRouteController, Store {
  final _$serviceIdAtom = Atom(name: '_MapRouteController.serviceId');

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

  final _$serviceEntityAtom = Atom(name: '_MapRouteController.serviceEntity');

  @override
  ServiceEntity? get serviceEntity {
    _$serviceEntityAtom.reportRead();
    return super.serviceEntity;
  }

  @override
  set serviceEntity(ServiceEntity? value) {
    _$serviceEntityAtom.reportWrite(value, super.serviceEntity, () {
      super.serviceEntity = value;
    });
  }

  final _$dialogDataAtom = Atom(name: '_MapRouteController.dialogData');

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

  final _$initialLocationAsyncAction =
      AsyncAction('_MapRouteController.initialLocation');

  @override
  Future<CameraPosition> initialLocation() {
    return _$initialLocationAsyncAction.run(() => super.initialLocation());
  }

  final _$getServiceAsyncAction = AsyncAction('_MapRouteController.getService');

  @override
  Future<void> getService() {
    return _$getServiceAsyncAction.run(() => super.getService());
  }

  final _$updateStatusAsyncAction =
      AsyncAction('_MapRouteController.updateStatus');

  @override
  Future<void> updateStatus(String? observation) {
    return _$updateStatusAsyncAction.run(() => super.updateStatus(observation));
  }

  final _$updateLastLocationAsyncAction =
      AsyncAction('_MapRouteController.updateLastLocation');

  @override
  Future<void> updateLastLocation(
      {required double latitude, required double longitude}) {
    return _$updateLastLocationAsyncAction.run(() =>
        super.updateLastLocation(latitude: latitude, longitude: longitude));
  }

  @override
  String toString() {
    return '''
serviceId: ${serviceId},
serviceEntity: ${serviceEntity},
dialogData: ${dialogData}
    ''';
  }
}
