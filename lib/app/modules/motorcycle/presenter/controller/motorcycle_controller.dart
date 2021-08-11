import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/enum/motorcycle_colors_enum.dart';
import 'package:feelps/app/core/validations/app_validations.dart';
import 'package:feelps/app/modules/motorcycle/models/register_motorcycle_request.dart';
import 'package:feelps/app/modules/motorcycle/repository/motorcycle_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'motorcycle_controller.g.dart';

class MotorcycleController = _MotorcycleController with _$MotorcycleController;

abstract class _MotorcycleController with Store {
  final IMotorcycleRepository _repository;

  _MotorcycleController(this._repository);

  @observable
  String? brand;

  @observable
  String? model;

  @observable
  int? year;

  @observable
  String? photoBase64;

  @observable
  MotorcycleColorsEnum? color;

  @observable
  String? plate;

  @observable
  File? photo;

  @observable
  DialogDataEntity? dialogData;

  @action
  void formValidation() {
    if (brand == null || brand!.split(' ').length < 2) {
      dialogData = DialogDataEntity(
          title: "Atenção",
          description: "Informe a marca da sua moto corretamente!");
      return;
    }
    if (model == null || model!.split(' ').length < 2) {
      dialogData = DialogDataEntity(
          title: "Atenção",
          description: "Informe o modelo da sua moto corretamente!");
      return;
    }
    if (year == null || year!.toString().split(' ').length < 4) {
      dialogData = DialogDataEntity(
          title: "Atenção",
          description: "Informe o ano da sua moto corretamente!");
      return;
    }

    if (plate == null || !AppValidations.isPlateValid(plate)) {
      dialogData = DialogDataEntity(
          title: "Atenção",
          description: "Informe a placa da sua moto corretamente!");
      return;
    }

    dialogData = null;
  }

  @action
  Future<void> getImage({bool isFromGalery = true}) async {
    final _picker = ImagePicker();
    if (isFromGalery) {
      final XFile? pickedFile = await _picker.pickImage(
          imageQuality: 70, source: ImageSource.gallery);

      if (pickedFile != null) {
        photo = File(pickedFile.path);
      }
    } else {
      Modular.to.push(MaterialPageRoute(
        builder: (context) {
          return CameraCamera(
            cameraSide: CameraSide.back,
            enableZoom: false,
            resolutionPreset: ResolutionPreset.high,
            flashModes: [FlashMode.off],
            onFile: (file) {
              photo = File(file.path);
              Navigator.pop(context);
            },
          );
        },
      ));
    }
  }

  @action
  Future<void> registerMotorcycle() async {
    dialogData = null;
    late String base64;
    if (photo != null) {
      base64 = String.fromCharCodes(await photo!.readAsBytes());
    }
    final result = await _repository.registerMotorcycle(
      data: RegistermotorcycleRequest(
          brand: brand!,
          model: model!,
          year: year!,
          photoBase64: base64,
          color: color.toString(),
          plate: plate!),
    );
  }
}
