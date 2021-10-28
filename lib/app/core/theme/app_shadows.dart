import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';

class AppShadows {
  static List<BoxShadow> defaultBoxShadow = [
    BoxShadow(
        blurRadius: 4,
        offset: Offset(0, 4),
        color: AppColors.black.withOpacity(0.25))
  ];
}
