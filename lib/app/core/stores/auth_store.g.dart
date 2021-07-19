// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  final _$errorDataAtom = Atom(name: '_AuthStore.errorData');

  @override
  DialogDataEntity? get errorData {
    _$errorDataAtom.reportRead();
    return super.errorData;
  }

  @override
  set errorData(DialogDataEntity? value) {
    _$errorDataAtom.reportWrite(value, super.errorData, () {
      super.errorData = value;
    });
  }

  final _$deliverymanAtom = Atom(name: '_AuthStore.deliveryman');

  @override
  DeliverymanEntity? get deliveryman {
    _$deliverymanAtom.reportRead();
    return super.deliveryman;
  }

  @override
  set deliveryman(DeliverymanEntity? value) {
    _$deliverymanAtom.reportWrite(value, super.deliveryman, () {
      super.deliveryman = value;
    });
  }

  final _$makeLoginAsyncAction = AsyncAction('_AuthStore.makeLogin');

  @override
  Future<void> makeLogin({required LoginRequest data}) {
    return _$makeLoginAsyncAction.run(() => super.makeLogin(data: data));
  }

  @override
  String toString() {
    return '''
errorData: ${errorData},
deliveryman: ${deliveryman}
    ''';
  }
}
