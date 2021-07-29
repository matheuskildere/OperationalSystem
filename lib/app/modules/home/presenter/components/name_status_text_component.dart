import 'package:feelps/app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class NameStatusTextComponent extends StatelessWidget {
  final String name;
  final bool status;
  const NameStatusTextComponent({
    Key? key,
    required this.name,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Olá, $name",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontWeight: FontWeight.bold, color: AppColors.white)),
        SizedBox(
          height: 8,
        ),
        Text.rich(TextSpan(
            text: "Você está ",
            style: TextStyle(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400),
            children: [
              TextSpan(
                  text: status ? 'Disponível' : 'Indisponível',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900)),
              TextSpan(
                  text: " para entregas",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400))
            ]))
      ],
    );
  }
}
