import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:feelps/app/modules/register/presenter/pages/components/photo_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:feelps/app/modules/register/presenter/controller/register_controller.dart';

class RegisterUserPhotoPage extends StatefulWidget {
  const RegisterUserPhotoPage({ Key? key }) : super(key: key);

  @override
  _RegisterUserPhotoPageState createState() => _RegisterUserPhotoPageState();
}

class _RegisterUserPhotoPageState extends State<RegisterUserPhotoPage> {
  final controller = Modular.get<RegisterController>();
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25,),
          const DefaultBackButton(),
          const SizedBox(height: 20,),
          TitleSubtitleComponent(title: "Tire uma foto bacana para que possamos identificá-lo", subTitle: "Último passo"),
          const SizedBox(height: 49,),
          Observer(
            builder: (context) {
              return PhotoComponent(
                photo: controller.photo,
              );
            }
          ),
          const SizedBox(height: 49,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: DefaultButton(onPressed: ()async {
              await controller.getImage(isFromGalery: false);
            }, title: "Tirar uma Self",
            invertColors: true,),
          ),
          const SizedBox(height: 17,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: DefaultButton(onPressed: ()async {
              await controller.getImage();
            }, title: "Escolher na galeria",
            invertColors: true,),
          ),
        ],
      ),
      floatingActionButton: DefaultButton(onPressed: () async {
        print(controller.photo);
        if (controller.photo == null) {
          DefaultAlertDialog.show(
            barrierDismissible: true,
            dialogData: DialogDataEntity(title: "Atenção",
            description: "Para finalizar o cadastro é necessário registrar uma foto para reconhecimento!"));
        }else{
          await controller.makeRegister();
          if (controller.dialogData != null) {
            DefaultAlertDialog.show(
              barrierDismissible: true,
              dialogData: controller.dialogData!);
          }
        }
      }, title: "Próximo passo"),
    );
  }
}