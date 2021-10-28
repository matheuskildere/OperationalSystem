import 'package:feelps/app/core/theme/theme.dart';
import 'package:feelps/app/core/utils/app_columns.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:flutter/material.dart';

class ChangeStatusComponent extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const ChangeStatusComponent(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppColumns.column11(context: context),
      margin: EdgeInsets.symmetric(horizontal: 33, vertical: 50),
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DefaultButton(onPressed: onPressed, title: title),
    );
  }
}
