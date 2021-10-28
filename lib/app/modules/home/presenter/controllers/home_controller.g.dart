// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeController, Store {
  final _$isAvaliableAtom = Atom(name: '_HomeController.isAvaliable');

  @override
  bool get isAvaliable {
    _$isAvaliableAtom.reportRead();
    return super.isAvaliable;
  }

  @override
  set isAvaliable(bool value) {
    _$isAvaliableAtom.reportWrite(value, super.isAvaliable, () {
      super.isAvaliable = value;
    });
  }

  final _$isAvaliableChangedAsyncAction =
      AsyncAction('_HomeController.isAvaliableChanged');

  @override
  Future<void> isAvaliableChanged({required bool value}) {
    return _$isAvaliableChangedAsyncAction
        .run(() => super.isAvaliableChanged(value: value));
  }

  final _$getStatusAvaliableAsyncAction =
      AsyncAction('_HomeController.getStatusAvaliable');

  @override
  Future<void> getStatusAvaliable() {
    return _$getStatusAvaliableAsyncAction
        .run(() => super.getStatusAvaliable());
  }

  final _$updateLastLocationAsyncAction =
      AsyncAction('_HomeController.updateLastLocation');

  @override
  Future<void> updateLastLocation(
      {required double latitude, required double longitude}) {
    return _$updateLastLocationAsyncAction.run(() =>
        super.updateLastLocation(latitude: latitude, longitude: longitude));
  }

  @override
  String toString() {
    return '''
isAvaliable: ${isAvaliable}
    ''';
  }
}
