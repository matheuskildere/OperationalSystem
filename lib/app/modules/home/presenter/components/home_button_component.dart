import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_icons.dart';
import 'package:feelps/app/core/utils/app_columns.dart';
import 'package:flutter/material.dart';

class HomeButtonComponent extends StatelessWidget {
  final bool isAvailable;
  final String title;
  final String icon;
  final void Function() onPress;
  const HomeButtonComponent(
      {Key? key,
      required this.isAvailable,
      required this.title,
      required this.icon,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppColumns.column4(context: context),
      height: AppColumns.column4(context: context),
      decoration: BoxDecoration(
          color: isAvailable ? AppColors.background : AppColors.secondary,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppIcon(
              icon: icon,
              appIconType: AppIconType.png,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.button!.copyWith(fontSize: 15),
            )
          ]),
    );
  }
}
