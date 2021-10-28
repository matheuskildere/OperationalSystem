import 'package:feelps/app/modules/auth/presenter/controller/auth_controller.dart';
import 'package:feelps/app/modules/auth/presenter/pages/auth_page.dart';
import 'package:feelps/app/modules/register/presenter/controller/register_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/pages/recover_password_page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => RegisterController(i())),
        Bind((i) => AuthController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => AuthPage()),
        ChildRoute('recover-password',
            child: (_, args) => RecoverPasswordPage()),
      ];
}
