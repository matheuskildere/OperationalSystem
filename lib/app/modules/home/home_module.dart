import 'package:feelps/app/modules/historic/presenter/controller/historic_controller.dart';
import 'package:feelps/app/modules/historic/presenter/pages/historic_page.dart';
import 'package:feelps/app/modules/historic/repositories/historic_repository.dart';
import 'package:feelps/app/modules/home/presenter/controllers/home_controller.dart';
import 'package:feelps/app/modules/home/presenter/pages/home_page.dart';
import 'package:feelps/app/modules/home/presenter/pages/my_data_page.dart';
import 'package:feelps/app/modules/home/repositories/home_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i())),
        Bind((i) => HistoricController(i())),
        Bind<IHomeRepository>((i) => HomeRepository(i(), i())),
        Bind<IHistoricRepository>(
          (i) => HistoricRepository(
            i(),
            i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => HomePage()),
        ChildRoute('my-data', child: (_, args) => MyDataPage()),
        ChildRoute('historic', child: (_, args) => HistoricPage()),
      ];
}
