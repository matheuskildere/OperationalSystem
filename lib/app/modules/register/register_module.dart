
import 'package:feelps/app/modules/register/presenter/pages/register_personal_data_page.dart';
import 'package:feelps/app/modules/register/presenter/pages/register_user_data_page.dart';
import 'package:feelps/app/modules/register/repositories/resgister_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:feelps/app/modules/register/presenter/controller/register_controller.dart';

class RegisterModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i)=> RegisterController(i())),
    Bind<IRegisterRepository>((i)=> RegisterRepository(i(), i(), i()))
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => RegisterPersonalDataPage()),
        ChildRoute('user-data', child: (_, args) => RegisterUserDataPage()),
        ChildRoute('user-photo', child: (_, args) => RegisterUserDataPage()),
      ];
}
