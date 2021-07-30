import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/utils/formatter.dart';
import 'package:feelps/app/core/validations/app_validations.dart';
import 'package:feelps/app/modules/register/models/register_request.dart';
import 'package:feelps/app/modules/register/repositories/resgister_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'register_controller.g.dart';

class RegisterController = _RegisterController with _$RegisterController;

abstract class _RegisterController with Store {
  final IRegisterRepository _repository;

  _RegisterController(this._repository);

  @observable
  String? fullName;

  @observable
  String? cpf;

  @observable
  String? phoneNumber;

  @observable
  DateTime? birthday;

  @observable
  String? email;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @observable
  File? photo;

  @observable
  DialogDataEntity? dialogData;

  @action
  Future<void> makeRegister() async {
    dialogData = null;
    late String base64;
    if (photo != null) {
      base64 = String.fromCharCodes(await photo!.readAsBytes());
    }

    final result = await _repository.registerDeliveryman(
        data: RegisterRequest(
            email: email!.trim(),
            birthday: birthday!,
            cpf: cpf!.trim(),
            fullName: fullName!.trim(),
            password: password!.trim(),
            phoneNumber: phoneNumber!.trim(),
            photoBase64: base64));

    result.fold((l) {
      dialogData = DialogDataEntity(title: l.title, description: l.message);
    }, (r) {});
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
  void formValidation() {
    if (fullName == null || fullName!.split(' ').length < 2) {
      dialogData = DialogDataEntity(
          title: "Atenção",
          description: "Informe seu nome completo corretamente!");
      return;
    }

    if (cpf == null ||
        !AppValidations.isCPFValid(Formatter.cpfWithOutFormatter(cpf!))) {
      dialogData = DialogDataEntity(
          title: "Atenção",
          description:
              "O CPF informado é inválido, revise os dados e tente novamente!!");
      return;
    }

    if (phoneNumber == null ||
        Formatter.phoneWithOutFormatter(phoneNumber!).length < 11) {
      dialogData = DialogDataEntity(
          title: "Atenção", description: "Digite um número de celular válido!");
      return;
    }
    dialogData = null;
  }

  @action
  void formValidation2() {
    if (email == null || !AppValidations.isEmailValid(email)) {
      dialogData = DialogDataEntity(
          title: "Atenção",
          description: "Informe um e-mail correto para continuar!");
      return;
    }

    if (password == null || password!.length <= 6) {
      dialogData = DialogDataEntity(
          title: "Senha inválida",
          description:
              "Para continuar informe uma senha com mais de 6 caracteres.");
      return;
    }

    if (confirmPassword != password) {
      dialogData = DialogDataEntity(
          title: "Senha inválida",
          description: "A senha informada difere da confirmação de senha!");
      return;
    }

    if (password == null || password!.length < 6) {
      dialogData = DialogDataEntity(
          title: "Atenção",
          description:
              "Para continuar informe uma senha com mais de 6 caracteres.");
      return;
    }
    dialogData = null;
  }
}
