import 'package:feelps/app/modules/motorcycle/presenter/pages/manage_motorcycle_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MotorcycleModule extends Module {
  @override
  List<Bind> get binds => [
        // Bind((i) => RegisterController(i())),
        // Bind<IRegisterRepository>((i) => RegisterRepository(i(), i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => ManageMotorcyclePage()),
      ];
}
