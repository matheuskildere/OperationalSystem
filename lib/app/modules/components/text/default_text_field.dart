import 'package:feelps/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class DefaultTextField extends StatefulWidget {
  final String? labelText;
  final bool isPassword;
  final bool readOnly;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? suffixIcon;
  final Widget? suffixText;
  final TextEditingController? controller;
  final TextInputType? type;
  final TextInputAction? action;
  final Function()? onTap;
  final bool? hasError;
  final FocusNode? focusNode;
  final int? maxLines;
  final Color? labelColor;
  final void Function()? onTapSuffixIcon;
  final String? initialValue;
  final String mask;
  final bool isFloat;
  final bool enabled;
  final String? text;
  final TextAlign align;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;

  const DefaultTextField(
      {Key? key,
      this.labelText,
      this.text,
      this.labelColor,
      this.isPassword = false,
      this.readOnly = false,
      this.isFloat = false,
      this.hintText,
      this.onChanged,
      this.onFieldSubmitted,
      this.suffixIcon,
      this.suffixText,
      this.mask = '',
      this.controller,
      this.onTap,
      this.hasError = false,
      this.type,
      this.action,
      this.focusNode,
      this.maxLines = 1,
      this.initialValue,
      this.onTapSuffixIcon,
      this.inputFormatters,
      this.enabled = true,
      this.align = TextAlign.start,
      this.textCapitalization})
      : super(key: key);

  @override
  _DefaultTextFieldState createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    if (widget.controller == null) {
      if (widget.isFloat) {
        _controller = MoneyMaskedTextController();
      } else {
        if (widget.mask.isNotEmpty) {
          _controller = MaskedTextController(
            mask: widget.mask,
          );
        } else {
          _controller = TextEditingController();
        }
      }
    } else {
      _controller = widget.controller!;
    }

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }

    _controller.addListener(() {
      if (_controller.selection.start < 0) {
        _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.text != null) {
      _controller.text = widget.text ?? '';
      if (widget.mask.isNotEmpty && _controller is MaskedTextController) {
        (_controller as MaskedTextController).updateMask(widget.mask);
      }
    }
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 4),
                color: AppColors.black.withOpacity(0.25))
          ]),
      child: TextFormField(
        enabled: widget.enabled,
        textAlign: widget.align,
        maxLines: widget.maxLines,
        focusNode: widget.focusNode,
        inputFormatters: widget.inputFormatters,
        textCapitalization: widget.textCapitalization == null
            ? TextCapitalization.none
            : widget.textCapitalization!,
        onChanged: widget.onChanged ??
            (value) {
              setState(() {});
            },
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        textInputAction: widget.action,
        onFieldSubmitted: widget.onFieldSubmitted,
        keyboardType: widget.type,
        obscureText: widget.isPassword,
        controller: widget.controller ?? _controller,
        style: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(color: AppColors.black),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintText: widget.hintText,
            errorText: widget.hasError! ? '' : null,
            errorStyle: TextStyle(height: 0),
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: widget.labelColor ?? AppColors.grey),
            labelText: widget.labelText,
            labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: _controller.text.isNotEmpty
                    ? AppColors.black
                    : AppColors.grey),
            suffixIcon: widget.suffixIcon != null
                ? AppIcon(
                    icon: widget.suffixIcon!,
                    color: textIsNotEmpty() ? AppColors.black : AppColors.grey,
                    onTap: widget.onTapSuffixIcon,
                  )
                : widget.suffixText != null
                    ? Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: widget.suffixText)
                    : null,
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: _controller.text.isNotEmpty
                        ? AppColors.error
                        : AppColors.black)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: _controller.text.isNotEmpty
                        ? AppColors.black
                        : AppColors.white)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: _controller.text.isNotEmpty
                        ? AppColors.black
                        : AppColors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: _controller.text.isNotEmpty
                        ? AppColors.black
                        : AppColors.white)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.error)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.black))),
      ),
    );
  }

  bool textIsNotEmpty() {
    return widget.controller != null
        ? widget.controller!.text.isNotEmpty
        : _controller.text.isNotEmpty;
  }
}
