import 'package:feelps/app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class TitleSubtitleComponent extends StatelessWidget {
  final String title;
  final String subTitle;
  const TitleSubtitleComponent({ Key? key, required this.title, required this.subTitle }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(subTitle, 
        style: Theme.of(context).textTheme.headline2!.copyWith(
          color: AppColors.black
        ),),
        Text(title, 
        style: Theme.of(context).textTheme.headline1!.copyWith(
          color: AppColors.black,
          fontSize: 25
        ),)
      ],
    );
  }
}