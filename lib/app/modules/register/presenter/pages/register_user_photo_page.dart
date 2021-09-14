import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/core/theme/app_icons.dart';
import 'package:feelps/app/core/theme/app_routes.dart';
import 'package:feelps/app/core/utils/app_columns.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:feelps/app/modules/register/presenter/pages/components/photo_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:feelps/app/modules/register/presenter/controller/register_controller.dart';

class RegisterUserPhotoPage extends StatefulWidget {
  const RegisterUserPhotoPage({Key? key}) : super(key: key);

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
          const SizedBox(
            height: 25,
          ),
          const DefaultBackButton(),
          const SizedBox(
            height: 20,
          ),
          TitleSubtitleComponent(
              title: "Tire uma foto bacana para que possamos identificá-lo",
              subTitle: "Último passo"),
          const SizedBox(
            height: 49,
          ),
          Observer(builder: (context) {
            return PhotoComponent(
              photo: controller.photo,
            );
          }),
          const SizedBox(
            height: 49,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: DefaultButton(
              onPressed: () async {
                await controller.getImage(isFromGalery: false);
              },
              title: "Tirar uma Selfie",
              invertColors: true,
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: DefaultButton(
              onPressed: () async {
                await controller.getImage();
              },
              title: "Escolher na galeria",
              invertColors: true,
            ),
          ),
          SizedBox(
            height: AppColumns.column3(context: context),
          ),
        ],
      ),
      floatingActionButton: DefaultButton(
          onPressed: () async {
            print(controller.photo);
            if (controller.photo == null) {
              DefaultAlertDialog.show(
                  barrierDismissible: true,
                  dialogData: DialogDataEntity(
                      title: "Atenção",
                      description:
                          "Para finalizar o cadastro é necessário registrar uma foto para reconhecimento!"));
            } else {
              await controller.makeRegister();
              if (controller.dialogData != null) {
                DefaultAlertDialog.show(
                    barrierDismissible: true,
                    dialogData: controller.dialogData!);
              } else {
                await Modular.get<AuthStore>().getCurrentUser();
                congratulation();
              }
            }
          },
          title: "Finalizar Cadastro"),
    );
  }

  Future<void> congratulation() async {
    await DefaultAlertDialog.show(
        barrierDismissible: true,
        dialogData: DialogDataEntity(
            icon: AppIcons.checkCircle,
            title: "Parabêns",
            description:
                "Finalizamos seu cadastro com sucesso, agora iremos analisar seus dados e se tudo estiver certo você estará realializando entregas logo logo!"));
    Modular.to.navigate(AppRoutes.home);
  }
}