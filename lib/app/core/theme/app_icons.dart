import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AppIconType { svg, png }

class AppIcons {
  static const path = "assets/icons";
  static const arrowRight = '$path/arrowRight.svg';
  static const arrowLeft = '$path/arrowLeft.svg';
  static const backDialog = '$path/backDialog.svg';
  static const cameraAdd = '$path/cameraAdd.svg';
  static const checkBoxUnchecked = '$path/checkboxUnchecked.svg';
  static const checkmark = '$path/checkmark.svg';
  static const eyeOpened = '$path/eyeOpened.svg';
  static const eyeClosed = '$path/eyeClosed.svg';
  static const headset = '$path/headset.svg';
  static const leaf = '$path/leaf.svg';
  static const leafUnic = '$path/leafUnic.svg';
  static const list = '$path/list.svg';
  static const locale = '$path/locale.svg';
  static const map = '$path/map.svg';
  static const person = '$path/person.svg';
  static const search = '$path/search.svg';
  static const whatsapp = '$path/whatsapp.svg';
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
      fit: fit!,
      color: color!,
      width: width!,
      height: height!,
      onTap: onTap!,
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
