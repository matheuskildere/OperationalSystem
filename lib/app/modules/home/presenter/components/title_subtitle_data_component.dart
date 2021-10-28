import 'package:feelps/app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class TitleSubtitleDataComponent extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleSubtitleDataComponent(
      {Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: AppColors.black)),
        SizedBox(
          height: 5,
        ),
        Text(subtitle,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: AppColors.grey))
      ],
    );
  }
}
