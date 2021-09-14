import 'package:feelps/app/modules/motorcycle/presenter/controller/motorcycle_controller.dart';
import 'package:feelps/app/modules/motorcycle/presenter/pages/manage_motorcycle_page.dart';
import 'package:feelps/app/modules/motorcycle/presenter/pages/register_motorcycle_page.dart';
import 'package:feelps/app/modules/motorcycle/repositories/motorcycle_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MotorcycleModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => MotorcycleController(i(), i())),
        Bind<IMotorcycleRepository>((i) => MotorcycleRepository(i(), i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => ManageMotorcyclePage()),
        ChildRoute('register', child: (_, args) => RegisterMotorcyclePage()),
      ];
}