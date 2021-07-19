// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthController, Store {
  Computed<bool>? _$isEmailValidComputed;

  @override
  bool get isEmailValid =>
      (_$isEmailValidComputed ??= Computed<bool>(() => super.isEmailValid,
              name: '_AuthController.isEmailValid'))
          .value;
  Computed<bool>? _$isPasswordValidComputed;

  @override
  bool get isPasswordValid =>
      (_$isPasswordValidComputed ??= Computed<bool>(() => super.isPasswordValid,
              name: '_AuthController.isPasswordValid'))
          .value;

  final _$emailAtom = Atom(name: '_AuthController.email');

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_AuthController.password');

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$errorDataAtom = Atom(name: '_AuthController.errorData');

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

  final _$makeLoginAsyncAction = AsyncAction('_AuthController.makeLogin');

  @override
  Future<void> makeLogin() {
    return _$makeLoginAsyncAction.run(() => super.makeLogin());
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
errorData: ${errorData},
isEmailValid: ${isEmailValid},
isPasswordValid: ${isPasswordValid}
    ''';
  }
}
