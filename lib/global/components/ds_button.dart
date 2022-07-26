import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';

class ButtonType {
  const ButtonType._(this.type);

  final String type;
  static const normal = ButtonType._('normal');

  static const dark = ButtonType._('dark');
  static const success = ButtonType._('success');
  static const warning = ButtonType._('warning');
  static const disabled = ButtonType._('disabled');
  static const transparent = ButtonType._('transparent');
  static const normal_black = ButtonType._('normal_black');
  static const normal_tomato = ButtonType._('normal_tomato');
  static const decline = ButtonType._('decline');

  @override
  String toString() {
    return const <String, String>{
      'normal': 'ButtonType.normal',
      'dark': 'ButtonType.dark',
      'transparent': 'ButtonType.transparent',
      'success': 'ButtonType.success',
      'warning': 'ButtonType.warning',
      'disabled': 'ButtonType.disabled',
      'normal_black': 'ButtonType.normal_black',
      'normal_tomato': 'ButtonType.normal_tomato',
      'decline': 'ButtonType.decline'
    }[type]!;
  }

  Color? buttonColor() {
    return const <String, Color>{
      'normal': DSColors.blue03,
      'normal_blue02': DSColors.blue02,
      'normal_blue04': Colors.transparent,
      'dark': DSColors.blue04,
      'transparent': Colors.transparent,
      'success': DSColors.blue03,
      'warning': DSColors.red01,
      'disabled': DSColors.blue03,
      'normal_black': DSColors.blue03,
      'decline': DSColors.decline,
    }[type];
  }

  Color? textColor() {
    return const <String, Color>{
      'normal': Colors.white,
      'dark': Colors.white,
      'transparent': DSColors.gray3,
      'success': DSColors.gray3,
      'warning': Colors.white,
      'disabled': DSColors.gray3,
      'normal_black': DSColors.black,
      'normal_tomato': DSColors.tomato,
      'decline': Colors.white,
    }[type];
  }
}

class DSButton extends StatelessWidget {
  // final Size size;
  final String text;
  final Function press;
  final EdgeInsets? margin;
  final double? width;
  final double height;
  final double radius;
  final ButtonType type;
  final double fontSize;
  final FontWeight fontWeight;
  DSButton(
      {
      // required this.size,
      Key? key,
      required this.text,
      required this.press,
      this.margin,
      this.width,
      this.height = 50,
      this.radius = 14,
      this.type = ButtonType.normal,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  Color? color = DSColors.tomato;
  Color? textColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    color = type.buttonColor();
    textColor = type.textColor();
    return Container(
      // color: Colors.red,
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 0),
          color: color,
          onPressed: press as void Function()?,
          child: Text(
            text,
            style: DSTextStyles.button.copyWith(color: textColor, fontSize: fontSize, fontWeight: fontWeight),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('height', height));
  }
}
