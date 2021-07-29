import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_routes.dart';
import 'package:feelps/app/modules/auth/presenter/controller/auth_controller.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
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
              title: "Dados de usuário", subTitle: "Agora precisamos dos seus"),
          const SizedBox(
            height: 40,
          ),
          Observer(builder: (context) {
            return DefaultTextField(
              labelText: "E-mail",
              type: TextInputType.emailAddress,
              hasError: !controller.isEmailValid,
              action: TextInputAction.next,
              onChanged: (value) => controller.email = value,
            );
          }),
          const SizedBox(
            height: 20,
          ),
          Observer(builder: (context) {
            return DefaultTextField(
              labelText: "Senha",
              hasError: !controller.isPasswordValid,
              onChanged: (value) => controller.password = value,
              isPassword: true,
              action: TextInputAction.next,
            );
          }),
          const SizedBox(
            height: 11,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => Modular.to.pushNamed(AppRoutes.recoverPassword),
              child: Text(
                "Esqueci minha senha",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18, color: AppColors.grey),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: DefaultButton(
          onPressed: () async {
            if (controller.isEmailValid && controller.isPasswordValid) {
              await controller.makeLogin();
              if (controller.errorData != null) {
                DefaultAlertDialog.show(
                    barrierDismissible: true,
                    dialogData: controller.errorData!);
              } else {
                Modular.to.navigate(AppRoutes.home);
              }
            }
          },
          title: "Entrar"),
    );
  }
}
