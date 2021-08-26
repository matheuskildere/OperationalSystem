// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_route_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MapRouteController on _MapRouteController, Store {
  final _$directionsAtom = Atom(name: '_MapRouteController.directions');

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

  final _$getDirectionsAsyncAction =
      AsyncAction('_MapRouteController.getDirections');

  @override
  Future<DirectionsModel?> getDirections() {
    return _$getDirectionsAsyncAction.run(() => super.getDirections());
  }

  @override
  String toString() {
    return '''
directions: ${directions},
serviceId: ${serviceId},
dialogData: ${dialogData}
    ''';
  }
}
