import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_icons.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;
  final bool withScroll;
  final double? paddingValue;
  final Color? backgroundColor;
  final bool withBackAction;
  const DefaultScaffold(
      {Key? key,
      required this.body,
      this.withScroll = true,
      this.paddingValue,
      this.floatingActionButton,
      this.backgroundColor,
      this.withBackAction = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor ?? AppColors.background,
        body: withScroll
            ? SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: paddingValue ?? 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (withBackAction) BackButtonAction(),
                    body,
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingValue ?? 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (withBackAction) BackButtonAction(),
                    body,
                  ],
                ),
              ),
        floatingActionButton: !_keyboardIsOpen
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: floatingActionButton,
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class BackButtonAction extends StatelessWidget {
  const BackButtonAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, top: 60, bottom: 23),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: AppIcon(
          icon: AppIcons.arrowBack,
          height: 15,
        ),
      ),
    );
  }
}
