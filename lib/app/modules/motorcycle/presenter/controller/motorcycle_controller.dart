import 'dart:convert';
import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/entities/mtorcycle_entity.dart';
import 'package:feelps/app/core/enum/motorcycle_colors_enum.dart';
import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/core/validations/app_validations.dart';
import 'package:feelps/app/modules/motorcycle/models/register_motorcycle_request.dart';
import 'package:feelps/app/modules/motorcycle/repository/motorcycle_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

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
  MotorcycleColorsEnum? color;

  @observable
  String? plate;

  @observable
  File? newPhoto;

  @observable
  File? currentPhoto;

  @observable
  DialogDataEntity? dialogData;

  @observable
  MotorcycleEntity? motorcycle;

  @action
  void formValidation() {
    if (brand == null || brand!.length < 3) {
      dialogData = DialogDataEntity(
          title: "Atenção",
          description: "Informe a marca da sua moto corretamente!");
      return;
    }
    if (model == null || model!.length < 3) {
      dialogData = DialogDataEntity(
          title: "Atenção",
          description: "Informe o modelo da sua moto corretamente!");
      return;
    }
    if (year == null || year!.toString().length < 4) {
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
    if (newPhoto == null) {
      dialogData = DialogDataEntity(
          title: "Atenção", description: "Adicone uma foto da sua moto!");
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
        newPhoto = File(pickedFile.path);
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
              newPhoto = File(file.path);
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
    if (newPhoto != null) {
      base64 = base64Encode(await newPhoto!.readAsBytes());
    }
    final result = await _repository.registerMotorcycle(
      data: RegisterMotorcycleRequest(
          brand: brand!,
          model: model!,
          year: year!,
          photoBase64: base64,
          color: color!,
          plate: plate!),
    );
    result.fold((l) {
      dialogData = DialogDataEntity(title: l.title, description: l.message);
    }, (r) async {
      motorcycle = motorcycle = MotorcycleEntity(
          brand: brand!,
          model: model!,
          year: year!,
          photoBase64: base64Encode(await newPhoto!.readAsBytes()),
          color: color!,
          plate: plate!);
      currentPhoto = newPhoto;
      cleanFields();
      // Modular.get<AuthStore>().deliveryman!.motorcycle = MotorcycleEntity(
      //     brand: brand!,
      //     model: model!,
      //     year: year!,
      //     photoBase64: base64Encode(await newPhoto!.readAsBytes()),
      //     color: color!,
      //     plate: plate!);
    });
  }

  @action
  Future<void> getMotorcycle() async {
    final result = await _repository.getMotorcycle();
    result.fold((l) {
      dialogData = DialogDataEntity(title: l.title, description: l.message);
    }, (r) async {
      motorcycle = r;
      if (r != null) {
        final String dir = (await getApplicationDocumentsDirectory()).path;
        final img.Image tempImage =
            img.decodeImage(base64Decode(motorcycle!.photoBase64))!;

        currentPhoto = File("$dir/motorcyclePhoto.png")
          ..writeAsBytes(img.encodePng(tempImage));
      }
    });
  }

  void cleanFields() {
    brand = null;
    model = null;
    year = null;
    color = null;
    newPhoto = null;
    plate = null;
  }

  Future<void> deleteMotorcycle() async {
    final result = await _repository.deleteMotorcycle();
    result.fold((l) {
      dialogData = DialogDataEntity(title: l.title, description: l.message);
    }, (r) async {
      motorcycle = null;
      currentPhoto = null;
    });
  }
}
