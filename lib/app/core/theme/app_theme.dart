import 'package:feelps/app/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

final theme = ThemeData(
    backgroundColor: AppColors.background,
    fontFamily: 'Roboto',
    textTheme: AppTypography.textTheme,
    primaryColor: AppColors.primary,
    buttonColor: AppColors.primary,
    accentColor: Colors.white,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primary)),
    textButtonTheme: textButtonThemeData,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppTypography.hintText.copyWith(color: AppColors.grey),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.grey)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.grey)),
    ));

final textButtonThemeData = TextButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          const Set<MaterialState> interactiveStates = <MaterialState>{
            MaterialState.disabled,
          };
          if (states.any(interactiveStates.contains)) {
            return AppColors.grey;
          }
          return AppColors.primary;
        }),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 16, vertical: 18)),
        elevation: MaterialStateProperty.all(4),
        shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.80)),
        textStyle: MaterialStateProperty.all(
            AppTypography.buttonText.copyWith(color: Colors.white))));
