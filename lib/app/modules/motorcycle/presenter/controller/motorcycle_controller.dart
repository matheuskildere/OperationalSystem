import 'dart:io';
import 'dart:math';

import 'package:camera_camera/camera_camera.dart';
import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/entities/motorcycle_entity.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/modules/motorcycle/models/motorcicly_color_model.dart';
import 'package:feelps/app/modules/motorcycle/models/register_motorcycle_request.dart';
import 'package:feelps/app/modules/motorcycle/repositories/motorcycle_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'motorcycle_controller.g.dart';

class MotorcycleController = _MotorcycleController with _$MotorcycleController;

abstract class _MotorcycleController with Store {
  final IMotorcycleRepository _repository;
  final AuthStore _auth;

  _MotorcycleController(this._repository, this._auth);

  @observable
  String? brand;

  @observable
  String? model;

  @observable
  int? year;

  @observable
  MotorciclyColorEntity? color;

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

  @observable
  List<MotorciclyColorEntity> colors = [];

  @observable
  String? errorMessage;

  @action
  void formValidation() {
    dialogData = null;
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

    if (plate == null) {
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
  Future<String> uploadPhoto() async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final img.Image temp =
        img.decodeImage(File(newPhoto!.path).readAsBytesSync())!;
    final int rand = Random().nextInt(10000);
    final uploadphoto = await File("$dir/${rand}motorcyclePhoto.png")
        .writeAsBytes(img.encodePng(temp));
    final UploadTask task = FirebaseStorage.instance
        .ref()
        .child(
            'deliveryman-${appFlavor!.title}/${_auth.deliveryman!.id!}/motorcycle')
        .putFile(uploadphoto);
    final TaskSnapshot tasksnapshot = await task.whenComplete(() => null);
    final String url = await tasksnapshot.ref.getDownloadURL();
    return url;
  }

  @action
  Future<void> registerMotorcycle() async {
    dialogData = null;
    late String url;
    if (newPhoto != null) {
      url = await uploadPhoto();
    }
    final result = await _repository.registerMotorcycle(
      data: RegisterMotorcycleRequest(
          brand: brand!,
          model: model!,
          year: year!,
          photoUrl: url,
          color: MotorciclyColorModel(color: color!.color, name: color!.name),
          plate: plate!),
    );
    result.fold((l) {
      dialogData = DialogDataEntity(title: l.title, description: l.message);
    }, (r) async {
      motorcycle = MotorcycleEntity(
          brand: brand!,
          model: model!,
          year: year!,
          photoUrl: url,
          color: color!,
          plate: plate!);
      Modular.get<AuthStore>().deliveryman = Modular.get<AuthStore>()
          .deliveryman!
          .copyWith(motorcycle: motorcycle);
      currentPhoto = newPhoto;
      cleanFields();
      Modular.to.pop();
    });
  }

  @action
  Future<void> getMotorcycle() async {
    await getColors();
    final result = await _repository.getMotorcycle();
    result.fold((l) {
      dialogData = DialogDataEntity(title: l.title, description: l.message);
      errorMessage = l.message;
    }, (r) async {
      motorcycle = r;
      if (r != null) {
        final response = await http.get(Uri.parse(motorcycle!.photoUrl));
        final documentDirectory = await getApplicationDocumentsDirectory();
        final int rand = Random().nextInt(10000);
        final file =
            File('${documentDirectory.path}/${rand}motorcyclePhoto.png');
        file.writeAsBytesSync(response.bodyBytes);
        currentPhoto = file;
      } else {
        errorMessage =
            'Oops, parece que você ainda não\npossui uma motocicleta cadastrada.';
      }
    });
  }

  @action
  Future<void> getColors() async {
    final result = await _repository.getColors();
    result.fold((l) {}, (r) async {
      colors = r;
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
      final deliveryMan = Modular.get<AuthStore>().deliveryman;
      if (deliveryMan!.motorcycle != null) {
        Modular.get<AuthStore>().deliveryman = deliveryMan.copyWith();
      }
      errorMessage =
          'Oops, parece que você ainda não\npossui uma motocicleta cadastrada.';
    });
  }
}
