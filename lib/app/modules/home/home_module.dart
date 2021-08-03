import 'package:feelps/app/modules/home/presenter/controllers/home_controller.dart';
import 'package:feelps/app/modules/home/presenter/pages/home_page.dart';
import 'package:feelps/app/modules/home/presenter/pages/my_data_page.dart';
import 'package:feelps/app/modules/home/repositories/home_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i())),
        Bind<IHomeRepository>((i) => HomeRepository(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => HomePage()),
        ChildRoute('my-data', child: (_, args) => MyDataPage())
      ];
}
