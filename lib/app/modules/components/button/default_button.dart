import 'dart:async';
import 'package:feelps/app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatefulWidget {
  final FutureOr<void> Function() onPressed;
  final double? width;
  final double? height;
  final String title;
  final bool smallTitle;
  final bool isMediumButton;
  final bool invertColors;
  final bool successColor;
  final bool? isLoading;
  const DefaultButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.smallTitle = false,
    this.isLoading,
    this.invertColors = false,
    this.successColor = false,
    this.height,
    this.width,
    this.isMediumButton = false,
  }) : super(key: key);

  @override
  _DefaultButtonState createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton>
    with SingleTickerProviderStateMixin {
  late bool _isLoading;
  late AnimationController _controller;
  @override
  void initState() {
    _isLoading = false;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading != null) {
      _isLoading = widget.isLoading!;
    }
    return SizedBox(
      height: widget.height ?? 50,
      width: widget.isMediumButton ? 148 : widget.width ?? double.maxFinite,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          splashFactory: NoSplash.splashFactory,
          backgroundColor: MaterialStateProperty.all(
              widget.invertColors ? AppColors.white : widget.successColor ? AppColors.success :
               AppColors.primary),
        ),
        onPressed: !_isLoading
            ? () async {
                try {
                  setState(() {
                    _isLoading = true;
                  });
                  _controller.reverse();
                  await widget.onPressed();
                  setState(() {
                    _isLoading = false;
                  });
                } on Exception {
                  setState(() {
                    _isLoading = false;
                  });
                  rethrow;
                }
              }
            : null,
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedOpacity(
                duration: Duration(milliseconds: 350),
                opacity: _isLoading ? 0 : 1,
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.button!.copyWith(
                    fontSize: widget.smallTitle ? 15: null,
                      color: widget.invertColors
                          ? AppColors.primary 
                          : widget.successColor ? AppColors.white : AppColors.secondary),
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 350),
                opacity: _isLoading ? 1 : 0,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.secondary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
