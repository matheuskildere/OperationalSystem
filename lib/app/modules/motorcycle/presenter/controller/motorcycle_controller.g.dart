// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motorcycle_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MotorcycleController on _MotorcycleController, Store {
  final _$brandAtom = Atom(name: '_MotorcycleController.brand');

  @override
  String? get brand {
    _$brandAtom.reportRead();
    return super.brand;
  }

  @override
  set brand(String? value) {
    _$brandAtom.reportWrite(value, super.brand, () {
      super.brand = value;
    });
  }

  final _$modelAtom = Atom(name: '_MotorcycleController.model');

  @override
  String? get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(String? value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  final _$yearAtom = Atom(name: '_MotorcycleController.year');

  @override
  int? get year {
    _$yearAtom.reportRead();
    return super.year;
  }

  @override
  set year(int? value) {
    _$yearAtom.reportWrite(value, super.year, () {
      super.year = value;
    });
  }

  final _$photoBase64Atom = Atom(name: '_MotorcycleController.photoBase64');

  @override
  String? get photoBase64 {
    _$photoBase64Atom.reportRead();
    return super.photoBase64;
  }

  @override
  set photoBase64(String? value) {
    _$photoBase64Atom.reportWrite(value, super.photoBase64, () {
      super.photoBase64 = value;
    });
  }

  final _$colorAtom = Atom(name: '_MotorcycleController.color');

  @override
  MotorcycleColorsEnum? get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(MotorcycleColorsEnum? value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  final _$plateAtom = Atom(name: '_MotorcycleController.plate');

  @override
  String? get plate {
    _$plateAtom.reportRead();
    return super.plate;
  }

  @override
  set plate(String? value) {
    _$plateAtom.reportWrite(value, super.plate, () {
      super.plate = value;
    });
  }

  final _$photoAtom = Atom(name: '_MotorcycleController.photo');

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

  final _$dialogDataAtom = Atom(name: '_MotorcycleController.dialogData');

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

  final _$motorcycleAtom = Atom(name: '_MotorcycleController.motorcycle');

  @override
  MotorcycleEntity? get motorcycle {
    _$motorcycleAtom.reportRead();
    return super.motorcycle;
  }

  @override
  set motorcycle(MotorcycleEntity? value) {
    _$motorcycleAtom.reportWrite(value, super.motorcycle, () {
      super.motorcycle = value;
    });
  }

  final _$getImageAsyncAction = AsyncAction('_MotorcycleController.getImage');

  @override
  Future<void> getImage({bool isFromGalery = true}) {
    return _$getImageAsyncAction
        .run(() => super.getImage(isFromGalery: isFromGalery));
  }

  final _$registerMotorcycleAsyncAction =
      AsyncAction('_MotorcycleController.registerMotorcycle');

  @override
  Future<void> registerMotorcycle() {
    return _$registerMotorcycleAsyncAction
        .run(() => super.registerMotorcycle());
  }

  final _$_MotorcycleControllerActionController =
      ActionController(name: '_MotorcycleController');

  @override
  void formValidation() {
    final _$actionInfo = _$_MotorcycleControllerActionController.startAction(
        name: '_MotorcycleController.formValidation');
    try {
      return super.formValidation();
    } finally {
      _$_MotorcycleControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
brand: ${brand},
model: ${model},
year: ${year},
photoBase64: ${photoBase64},
color: ${color},
plate: ${plate},
photo: ${photo},
dialogData: ${dialogData},
motorcycle: ${motorcycle}
    ''';
  }
}
