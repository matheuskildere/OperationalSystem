import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;
  final bool withScroll;
  const DefaultScaffold(
      {Key? key,
      required this.body,
      this.withScroll = true,
      this.floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
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
        floatingActionButton: !_keyboardIsOpen
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: floatingActionButton,
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
