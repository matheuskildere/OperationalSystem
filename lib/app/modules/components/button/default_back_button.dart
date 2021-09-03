import 'dart:io';
import 'package:feelps/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DefaultBackButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;
  const DefaultBackButton({Key? key, this.onTap, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppIcon(
      icon: Platform.isAndroid ? AppIcons.arrowBack : AppIcons.arrowBackIOS,
      color: color ?? AppColors.black,
      onTap: onTap ??
          () {
            Modular.to.pop();
          },
    );
  }
}
