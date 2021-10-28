import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/theme/app_icons.dart';
import 'package:feelps/app/modules/auth/presenter/controller/auth_controller.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({Key? key}) : super(key: key);

  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final controller = Modular.get<AuthController>();
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
              title: "Enviaremos um e-mail de recuperação para você!",
              subTitle: "Esqueceu sua senha?"),
          const SizedBox(
            height: 40,
          ),
          Observer(builder: (context) {
            return DefaultTextField(
              labelText: "E-mail",
              initialValue: controller.email,
              type: TextInputType.emailAddress,
              hasError: !controller.isEmailValid,
              action: TextInputAction.next,
              onChanged: (value) => controller.email = value,
            );
          }),
        ],
      ),
      floatingActionButton: DefaultButton(
          onPressed: () async {
            await controller.recoverPassword();
            if (controller.errorData != null) {
              DefaultAlertDialog.show(
                  barrierDismissible: true, dialogData: controller.errorData!);
            } else {
              DefaultAlertDialog.show(
                  barrierDismissible: true,
                  dialogData: DialogDataEntity(
                      title: 'Sucesso',
                      icon: AppIcons.checkCircle,
                      description:
                          "Enviamos um email de recuperação para a conta informada!"));
            }
          },
          title: "Recuperar senha"),
    );
  }
}
