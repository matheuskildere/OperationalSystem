import 'package:feelps/app/core/theme/theme.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:feelps/app/modules/register/presenter/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterUserDataPage extends StatefulWidget {
  const RegisterUserDataPage({Key? key}) : super(key: key);

  @override
  _RegisterUserDataPageState createState() => _RegisterUserDataPageState();
}

class _RegisterUserDataPageState extends State<RegisterUserDataPage> {
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
              title: "Dados de usuário", subTitle: "Agora precisamos dos seus"),
          const SizedBox(
            height: 40,
          ),
          DefaultTextField(
              labelText: "E-mail",
              type: TextInputType.emailAddress,
              action: TextInputAction.next,
              onChanged: (value) => controller.email = value),
          const SizedBox(
            height: 20,
          ),
          DefaultTextField(
            labelText: "Senha",
            isPassword: true,
            action: TextInputAction.next,
            onChanged: (value) => controller.password = value,
          ),
          const SizedBox(
            height: 20,
          ),
          DefaultTextField(
            labelText: "Confirmação de senha",
            isPassword: true,
            onChanged: (value) => controller.confirmPassword = value,
          ),
        ],
      ),
      floatingActionButton: DefaultButton(
          onPressed: () {
            controller.formValidation2();
            if (controller.dialogData != null) {
              DefaultAlertDialog.show(
                  barrierDismissible: true, dialogData: controller.dialogData!);
            } else {
              Modular.to.pushNamed(AppRoutes.registerUserPhoto);
            }
          },
          title: "Próximo passo"),
    );
  }
}
