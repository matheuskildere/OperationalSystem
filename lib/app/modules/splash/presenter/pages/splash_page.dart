import 'package:feelps/app/core/theme/theme.dart';
import 'package:feelps/app/core/utils/app_columns.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: AppIcon(
        icon: AppImages.logoPretaSemFundo,
        appIconType: AppIconType.png,
        height: AppColumns.column6(context: context),
        width: AppColumns.column6(context: context),
      ),
    );
  }
}
