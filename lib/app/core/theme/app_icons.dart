import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AppIconType { svg, png }

class AppIcons {
  static const path = "assets/icons";
  static const arrowBack = '$path/arrowBack.svg';
  static const checkCircle = '$path/checkCircle.svg';
  static const close = '$path/close.svg';
  static const deliveryDining = '$path/deliveryDining.svg';
  static const deliveryDiningRounded = '$path/deliveryDiningRounded.svg';
  static const warning = '$path/warning.svg';
}

extension AppIconsExt on String {
  AppIcon icon({
    required String icon,
    BoxFit? fit,
    Color? color,
    double? width,
    double? height,
    void Function()? onTap,
  }) {
    return AppIcon(
      icon: this,
      fit: fit,
      color: color,
      width: width,
      height: height,
      onTap: onTap,
    );
  }
}

class AppIcon extends StatelessWidget {
  const AppIcon({
    required this.icon,
    this.fit,
    this.color,
    this.width,
    this.height,
    this.onTap,
    this.appIconType = AppIconType.svg,
  });

  final String icon;
  final BoxFit? fit;
  final Color? color;
  final double? height;
  final double? width;
  final void Function()? onTap;
  final AppIconType? appIconType;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: appIconType == AppIconType.svg
            ? SvgPicture.asset(
                icon,
                fit: fit ?? BoxFit.none,
                color: color,
                width: width ?? 24.0,
                height: height ?? 24.0,
              )
            : Image.asset(
                icon,
                width: width ?? 24.0,
                height: height ?? 24.0,
                filterQuality: FilterQuality.high,
              ),
      ),
    );
  }
}
