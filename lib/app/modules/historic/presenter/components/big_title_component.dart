import 'package:feelps/app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class BigTitleComponent extends StatelessWidget {
  final String title;
  const BigTitleComponent({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, bottom: 30),
      child: Text(
        title,
        style: AppTypography.h1,
      ),
    );
  }
}
