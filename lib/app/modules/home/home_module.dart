import 'package:feelps/app/modules/home/presenter/controllers/home_controller.dart';
import 'package:feelps/app/modules/home/presenter/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [Bind((i) => HomeController())];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => HomePage()),
      ];
}
