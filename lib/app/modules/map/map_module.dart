import 'package:dio/dio.dart';
import 'package:feelps/app/modules/map/presenter/controller/map_route_controller.dart';
import 'package:feelps/app/modules/map/presenter/pages/map_route_page.dart';
import 'package:feelps/app/modules/map/repositories/map_route_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MapModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => MapRouteController(i())),
        Bind((i) => Dio(i())),
        Bind((i) => BaseOptions()),
        Bind<IMapRouteRepository>((i) => MapRouteRepository(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/:serviceId',
            child: (_, args) => MapRoutePage(
                  serviceId: args.params['serviceId'].toString(),
                )),
      ];
}
