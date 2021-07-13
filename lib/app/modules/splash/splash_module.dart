import 'package:feelps/app/modules/splash/presenter/pages/onboarding_page.dart';
import 'package:feelps/app/modules/splash/presenter/pages/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => SplashPage()),
        ChildRoute('onboarding', child: (_, args) => OnboardingPage()),
      ];
}
