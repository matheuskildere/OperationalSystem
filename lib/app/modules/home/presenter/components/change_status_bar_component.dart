import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeSatatusBarComponent extends StatelessWidget {
  final bool isAvaliable;
  final void Function(bool value) onChangedAvaliable;
  const ChangeSatatusBarComponent(
      {Key? key, required this.isAvaliable, required this.onChangedAvaliable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
          color: isAvaliable ? AppColors.success : AppColors.primary,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
                "Ficar ${!isAvaliable ? 'disponível' : 'indisponível'} para entregas",
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(fontSize: 17, color: AppColors.white)),
            Switch.adaptive(
              value: isAvaliable,
              onChanged: onChangedAvaliable,
              activeColor: AppColors.grey,
              focusColor: AppColors.white,
              activeTrackColor: AppColors.white,
              inactiveThumbColor: AppColors.grey,
              inactiveTrackColor: AppColors.white,
            )
          ]),
    );
  }
}
