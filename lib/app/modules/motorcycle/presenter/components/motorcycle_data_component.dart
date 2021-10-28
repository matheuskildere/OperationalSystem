import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class MotorcycleDataComponent extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  const MotorcycleDataComponent({
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTypography.cardText,
            ),
            Text(
              subtitle,
              style: AppTypography.cardText
                  .copyWith(color: AppColors.subtitleGrey),
            ),
            SizedBox(
              height: 19,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 19),
          child: trailing ?? Container(),
        ),
      ],
    );
  }
}
