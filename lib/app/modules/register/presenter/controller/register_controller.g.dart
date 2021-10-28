// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterController on _RegisterController, Store {
  final _$fullNameAtom = Atom(name: '_RegisterController.fullName');

  @override
  String? get fullName {
    _$fullNameAtom.reportRead();
    return super.fullName;
  }

  @override
  set fullName(String? value) {
    _$fullNameAtom.reportWrite(value, super.fullName, () {
      super.fullName = value;
    });
  }

  final _$cpfAtom = Atom(name: '_RegisterController.cpf');

  @override
  String? get cpf {
    _$cpfAtom.reportRead();
    return super.cpf;
  }

  @override
  set cpf(String? value) {
    _$cpfAtom.reportWrite(value, super.cpf, () {
      super.cpf = value;
    });
  }

  final _$phoneNumberAtom = Atom(name: '_RegisterController.phoneNumber');

  @override
  String? get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String? value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  final _$birthdayAtom = Atom(name: '_RegisterController.birthday');

  @override
  DateTime? get birthday {
    _$birthdayAtom.reportRead();
    return super.birthday;
  }

  @override
  set birthday(DateTime? value) {
    _$birthdayAtom.reportWrite(value, super.birthday, () {
      super.birthday = value;
    });
  }

  final _$emailAtom = Atom(name: '_RegisterController.email');

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

  final _$passwordAtom = Atom(name: '_RegisterController.password');

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

  final _$confirmPasswordAtom =
      Atom(name: '_RegisterController.confirmPassword');

  @override
  String? get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String? value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$photoAtom = Atom(name: '_RegisterController.photo');

  @override
  File? get photo {
    _$photoAtom.reportRead();
    return super.photo;
  }

  @override
  set photo(File? value) {
    _$photoAtom.reportWrite(value, super.photo, () {
      super.photo = value;
    });
  }

  final _$dialogDataAtom = Atom(name: '_RegisterController.dialogData');

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

  final _$uploadPhotoAsyncAction =
      AsyncAction('_RegisterController.uploadPhoto');

  @override
  Future<String> uploadPhoto() {
    return _$uploadPhotoAsyncAction.run(() => super.uploadPhoto());
  }

  final _$makeRegisterAsyncAction =
      AsyncAction('_RegisterController.makeRegister');

  @override
  Future<void> makeRegister() {
    return _$makeRegisterAsyncAction.run(() => super.makeRegister());
  }

  final _$getImageAsyncAction = AsyncAction('_RegisterController.getImage');

  @override
  Future<void> getImage({bool isFromGalery = true}) {
    return _$getImageAsyncAction
        .run(() => super.getImage(isFromGalery: isFromGalery));
  }

  final _$_RegisterControllerActionController =
      ActionController(name: '_RegisterController');

  @override
  void formValidation() {
    final _$actionInfo = _$_RegisterControllerActionController.startAction(
        name: '_RegisterController.formValidation');
    try {
      return super.formValidation();
    } finally {
      _$_RegisterControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void formValidation2() {
    final _$actionInfo = _$_RegisterControllerActionController.startAction(
        name: '_RegisterController.formValidation2');
    try {
      return super.formValidation2();
    } finally {
      _$_RegisterControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fullName: ${fullName},
cpf: ${cpf},
phoneNumber: ${phoneNumber},
birthday: ${birthday},
email: ${email},
password: ${password},
confirmPassword: ${confirmPassword},
photo: ${photo},
dialogData: ${dialogData}
    ''';
  }
}
