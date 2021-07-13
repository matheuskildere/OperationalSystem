import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget body;
  final bool withScroll;
  const DefaultScaffold({Key? key, required this.body, this.withScroll = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: withScroll
            ? SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: body,
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: body,
              ),
      ),
    );
  }
}
