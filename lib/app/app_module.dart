import 'package:connectivity/connectivity.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/modules/auth/auth_module.dart';
import 'package:feelps/app/modules/auth/repositories/auth_repository.dart';
import 'package:feelps/app/modules/map/map_module.dart';
import 'package:feelps/app/modules/register/register_module.dart';
import 'package:feelps/app/modules/splash/splash_module.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => FirebaseAuth.instance),
        Bind((i) => FirebaseDatabase.instance),
        Bind((i) => Connectivity()),
        Bind<IConnectivityService>((i) => ConnectivityService(i())),
        Bind((i) => AuthStore(i())),
        Bind<IAuthRepository>((i) => AuthRepository(i(), i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/splash', module: SplashModule()),
        ModuleRoute('/register', module: RegisterModule()),
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/map', module: MapModule()),
        ModuleRoute('/home', module: HomeModule())
      ];
}
