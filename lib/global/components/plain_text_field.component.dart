import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';

class PlainTextField extends StatefulWidget {
  final Widget? child;
  final FocusNode? focusNode;
  final String? title;
  final String? hintText;
  final String? warningMessage;
  final FormFieldValidator<String>? validator;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool autocorrect;
  final bool showSecure;
  final bool showClear;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  bool isSecure = false;
  PlainTextField({
    Key? key,
    this.focusNode,
    this.child,
    this.title,
    this.hintText,
    this.autocorrect = false,
    this.warningMessage,
    this.validator,
    this.icon,
    this.isSecure = false,
    this.showSecure = false,
    this.showClear = false,
    this.onChanged,
    this.controller,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  _PlainTextFieldState createState() => _PlainTextFieldState();
}

class _PlainTextFieldState extends State<PlainTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20),
      // padding: EdgeInsets.fromLTRB(20, 7, 20, 0),
      // height: cellHeight,
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        autocorrect: widget.autocorrect,
        textCapitalization: TextCapitalization.none,
        obscureText: widget.isSecure,
        onChanged: (text) {
          setState(() {});
          if (widget.onChanged != null) {
            widget.onChanged!(text);
          }
        },
        validator: widget.warningMessage == null || widget.validator != null ? widget.validator : _validateText,
        onEditingComplete: widget.onEditingComplete,
        onFieldSubmitted: widget.onFieldSubmitted,
        textInputAction: widget.textInputAction,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
          isDense: true,
          labelText: widget.title,
          hintText: widget.hintText,
          fillColor: Colors.blue,
          icon: widget.icon == null ? null : Icon(widget.icon, color: kPrimaryColor),
          suffixIcon: suffixIcon(),
        ),
      ),
    );
  }

  Widget? suffixIcon() {
    if (widget.showSecure) {
      return IconButton(
        icon: widget.isSecure
            ? Icon(Icons.visibility, color: kPrimaryColor)
            : Icon(Icons.visibility_off, color: kPrimaryColor),
        onPressed: () {
          setState(() {
            widget.isSecure = !widget.isSecure;
          });
        },
      );
    }
    if (widget.showClear) {
      return widget.controller!.text.length > 0
          ? IconButton(
              icon: Icon(Icons.clear_rounded, size: 15),
              onPressed: () {
                setState(() {
                  widget.controller!.clear();
                });
              })
          : null;
    }
    return null;
  }

  String? _validateText(String? text) {
    if (text == null || text.isEmpty || text.trim().length == 0) {
      return widget.warningMessage;
    } else {
      return null;
    }
  }
}
