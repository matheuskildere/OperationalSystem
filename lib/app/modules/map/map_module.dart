
import 'package:feelps/app/modules/map/presenter/pages/map_route_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MapModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => MapRoutePage()),
  ];
}
