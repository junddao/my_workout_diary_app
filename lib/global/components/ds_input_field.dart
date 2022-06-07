import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';

class DSInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final String? warningMessage;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  const DSInputField({
    Key? key,
    this.controller,
    this.title,
    this.hintText,
    this.maxLines,
    this.minLines,
    this.warningMessage,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.onEditingComplete,
    this.keyboardType,
    this.inputFormatters,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: DSColors.black05),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(color: DSColors.black05),
        ),
        labelText: title,
        hintText: hintText,
        labelStyle: DSTextStyles.regular16Pinkish_grey,
        hintStyle: DSTextStyles.regular16Pinkish_grey,
      ),
      validator: warningMessage == null || validator != null ? validator : _validateText,
      onSaved: onSaved,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      onEditingComplete: onEditingComplete,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textAlign: textAlign ?? TextAlign.start,
    );
  }

  String? _validateText(String? text) {
    if (text == null || text.isEmpty) {
      return warningMessage;
    } else {
      return null;
    }
  }
}
