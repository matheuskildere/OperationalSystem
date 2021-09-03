import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/core/theme/app_routes.dart';
import 'package:feelps/app/core/theme/theme.dart';
import 'package:feelps/app/core/utils/app_columns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () async {
      await Modular.get<AuthStore>().getCurrentUser();
      if (Modular.get<AuthStore>().deliveryman != null) {
        Modular.to.navigate(AppRoutes.home);
      } else {
        Modular.to.navigate(AppRoutes.oborading);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppIcon(
          icon: AppImages.logoPretaSemFundo,
          appIconType: AppIconType.png,
          height: AppColumns.column6(context: context),
          width: AppColumns.column6(context: context),
        ),
      ),
    );
  }
}
